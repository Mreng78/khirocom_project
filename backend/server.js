require("dotenv").config();

const app = require("./src/config/app");
const { sequelize } = require("./src/models");

const port = process.env.PORT || 8000;

async function startServer() {
  try {
    await sequelize.authenticate();
    console.log("Database connected");

    app.listen(port,'0.0.0.0', () => {
      console.log(`The server is listening on port ${port}`);
    });

    console.log("Registered models:", Object.keys(sequelize.models));
    await sequelize.sync({ alter: true });
    console.log("Database synced successfully!");
  } catch (error) {
    console.error("Failed to start server:", error);
  }
}

startServer();
