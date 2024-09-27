const mongoose = require('mongoose');

// Definir o esquema do especialista
const EspecialistaSchema = new mongoose.Schema({
  nome: { type: String, required: true },
  especialidade: { type: String, required: true },
  imagemUrl: { type: String, required: true },
});

// Criar o modelo
const Especialista = mongoose.model('especialistas', EspecialistaSchema);

module.exports = Especialista;
