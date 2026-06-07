import express from 'express';
const app = express();
const PORT = 3000;
app.get('/ticker', (req, res) => {
    const tickers = ["AAPL", "EV", "IBM", "HSBC", "MS", "GOOG", "AMZ", "EY", "MX"];
    const ticker = tickers[Math.floor(Math.random() * tickers.length)];
    res.status(202).json({ ticker: ticker });
});
app.listen(PORT, () => {
    console.log('Server is listening at http://localhost:${PORT}');
});
