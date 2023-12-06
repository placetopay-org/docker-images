const {SecretsManagerClient, GetSecretValueCommand} = require('@aws-sdk/client-secrets-manager');

const getCliData = (prefix, alias = undefined) => {
    let data = undefined;
    const prefixIndex = process.argv.findIndex(
        (arg) => arg === prefix || (alias && arg === alias)
    );

    if (prefixIndex > 0) {
        const cliData = process.argv[prefixIndex + 1] ?? undefined;

        if (cliData) {
            data = cliData.includes("-") ? undefined : cliData;
        }
    }

    return data;
};

async function main() {
    const secret_name = getCliData('--SECRET_NAME');

    const client = new SecretsManagerClient({
        region: getCliData('--REGION'),
    });

    let response;

    try {
        response = await client.send(
            new GetSecretValueCommand({
                SecretId: secret_name,
                VersionStage: "AWSCURRENT",
            })
        );
    } catch (error) {
        throw error;
    }

    const secret = response.SecretString;

    const items = JSON.parse(secret)
    let content = '';

    for (const key in items) {
        if (Object.hasOwnProperty.call(items, key)) {
            const element = items[key];
            content += key + '=' + element + '\n'
        }
    }

    console.log(content)
}

main().then();
