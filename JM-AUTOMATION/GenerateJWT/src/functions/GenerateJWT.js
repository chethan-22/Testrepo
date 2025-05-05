const { app } = require('@azure/functions');
const jwt = require('jsonwebtoken');
const NodeRSA = require('node-rsa');
const { DefaultAzureCredential } = require('@azure/identity');
const { SecretClient } = require('@azure/keyvault-secrets');

app.http('GenerateJWT', {
    methods: ['GET'],
    authLevel: 'anonymous',
    handler: async (request, context) => {
        context.log(`Http function processed request for url "${request.url}"`);

        const appId = request.query.get('appId') || await request.text() || '';
        const keyVaultName = request.query.get('keyVaultName') || await request.text() || '';
        const secretName = request.query.get('secretName') || await request.text() || '';
        
        const credential = new DefaultAzureCredential();
        const vaultUrl = `https://${keyVaultName}.vault.azure.net`;
        const client = new SecretClient(vaultUrl, credential);
        const secret = await client.getSecret(secretName);

        const key = new NodeRSA(secret.value);
        const iat = Math.floor(Date.now() / 1000) - 60; // issued 60 seconds ago
        const exp = iat + 600; // expires in 10 minutes

        const payload = {
            iat: iat,
            exp: exp,
            iss: appId
        };

        const token = jwt.sign(payload, key.exportKey('private'), { algorithm: 'RS256' });
        
        return { body: token };
    }
});
