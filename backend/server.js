const express = require('express');
const app = express();
const port = 3000;
const mongoose = require('mongoose');
const dotenv = require('dotenv');
const franquiasRoute = require('./routes/franquias_route');
const userRoutes = require('./routes/user_route');
const { register } = require('./controllers/userController');

dotenv.config();

// Substitua pela URL de conexão do seu MongoDB Atlas
mongoose.connect('mongodb+srv://stellaaraujo:PimTurquesa@clusterpim.0v20e.mongodb.net/?retryWrites=true&w=majority&appName=ClusterPIM',{
}).then(() => {
  console.log('Conectado ao MongoDB Atlas');
}).catch((error) => {
  console.error('Erro ao conectar ao MongoDB:', error);
});

// Middleware para lidar com JSON
app.use(express.json());

// Usa a rota de franquias
app.use('/franquias', franquiasRoute);
app.use('/user', userRoutes);


// Servidor escutando na porta 3000
app.listen(port, () => {
  console.log(`Servidor rodando na porta ${port}`);
});
