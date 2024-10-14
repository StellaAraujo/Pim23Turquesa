  const express = require('express');
  const router = express.Router();
  const Profissional = require('../models/profissional');

  // Rota POST para criar um novo profissional e associá-lo a uma franquia
  router.post('/:franquiaId', async (req, res) => {
    const { nome, especialidade, horario, imagemUrl } = req.body;
    const { franquiaId } = req.params;

    try {
      // Cria um novo profissional e associa ao ID da franquia fornecida na rota
      const novoProfissional = new Profissional({ 
        nome, 
        especialidade, 
        franquiaId, // Adiciona o ID da franquia diretamente
        horario, 
        imagemUrl 
      });
      await novoProfissional.save(); // Salva no banco de dados
      res.status(201).json(novoProfissional); // Retorna o novo profissional criado
    } catch (error) {
      res.status(400).json({ message: 'Erro ao criar profissional', error });
    }
  });

  // Rota GET para buscar todos os profissionais de uma franquia específica
  router.get('/:franquiaId', async (req, res) => {
    try {
      const { franquiaId } = req.params;
      const profissionais = await Profissional.find({ franquiaId });
      res.json(profissionais);
    } catch (error) {
      res.status(500).json({ message: 'Erro ao buscar profissionais.' });
    }
  });


  module.exports = router;
