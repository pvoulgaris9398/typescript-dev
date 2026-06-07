import { getRandomValues } from 'crypto';
// Explicitly import Request as a type
import express from 'express';
import type { Request, Response } from 'express';


const app = express();
const PORT = 3000;

interface StockPriceListResponse {
    ticker: string,
}

app.get('/ticker', (req: Request, res: Response<StockPriceListResponse>) => {

    const tickers = ["AAPL", "EV", "IBM", "HSBC", "MS", "GOOG", "AMZ", "EY", "MX"];

    const ticker = tickers[Math.floor(Math.random() * tickers.length)];

    res.status(202).json({ ticker: ticker })
});

app.listen(PORT, () => {
    console.log(`Server is listening at http://localhost:${PORT}`);
});

