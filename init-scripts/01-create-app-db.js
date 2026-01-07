print('Creating application database and users...');

// Получаем переменные окружения
const appDb = process.env.MONGO_APP_DATABASE;
const appUser = process.env.MONGO_APP_USER;
const appPass = process.env.MONGO_APP_PASSWORD;
const readonlyUser = process.env.MONGO_READONLY_USER;
const readonlyPass = process.env.MONGO_READONLY_PASSWORD;

print(`Creating database: ${appDb}`);
print(`Creating users: ${appUser}, ${readonlyUser}`);

try {
    db = db.getSiblingDB(appDb);

    db.createUser({
        user: appUser,
        pwd: appPass,
        roles: [
            { role: "readWrite", db: appDb },
            { role: "dbAdmin", db: appDb },
            { role: "dbAdmin", db: "config" }
        ]
    });


    db.createUser({
        user: readonlyUser,
        pwd: readonlyPass,
        roles: [
            { role: "read", db: appDb },
            { role: "read", db: "local" }
        ]
    });

    print('Database and users created successfully!');

} catch (error) {
    print(`Error: ${error.message}`);
    throw error; // Проваливаем инициализацию при ошибке
}