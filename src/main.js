import express from 'express';
import bodyParser from 'body-parser';
import wkhtmltopdf from 'wkhtmltopdf';
import config from './config';

const app = express();

app.use(bodyParser.raw({
  type: () => true,
}));

app.get('/', (req, res) => {
  res.send('Use POST /compile');
});

app.post('/compile', (req, res) => {
  res.setHeader('content-type', 'application/pdf');
  wkhtmltopdf(`${req.body}`).pipe(res);
});

app.listen(config.port, () => {
  console.log('Server started at port %s', config.port); // eslint-disable-line no-console
});
