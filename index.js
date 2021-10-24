import express from 'express';
import bodyParser from 'body-parser';
import usersRoutes from './routes/users.js';

const app = express();
const PORT = 8080;

app.use(bodyParser.json());

app.use('/users', usersRoutes);

app.listen(PORT, () => {
    console.log(`Roomeet server running! on port: http://localhost:${PORT}`);
});

//ROUTING
app.get('/', (req,res) => {
    res.send('get request working.');
})

