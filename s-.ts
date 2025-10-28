import { Command } from "../command";

const pingCommand: Command = {
  name: "ping",
  aliases: ["p"],
  description: "Responde pong y muestra latencia simulada",
  usage: "!ping",
  execute: async ({ reply }) => {
    const start = Date.now();
    await reply("Pong... ⏳");
    const latency = Date.now() - start;
    await reply(`Pong! Latencia: ${latency} ms`);
  }
};

export default pingCommand;

// olviden esa mrd jajaja 😅