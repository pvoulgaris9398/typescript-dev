import express, { type Request, type Response } from 'express';
import pinoHttp from 'pino-http';

const app = express();
const PORT = 3000;

// Are we running locally?
const isProduction = process.env.NODE_ENV === 'production';

app.use(pinoHttp.default({
    transport: !isProduction
        ? { target: 'pino-pretty', options: { colorize: true } }
        : undefined,

    level: isProduction ? 'info' : 'debug',


}));

interface StockPriceListResponse {
    ticker: string,
}

app.get('/ticker', (req: Request, res: Response<StockPriceListResponse>) => {

    const tickers = ["AAPL", "EV", "IBM", "HSBC", "MS", "GOOG", "AMZ", "EY", "MX"];

    const ticker = tickers[Math.floor(Math.random() * tickers.length)];

    req.log.info({ currentTicker: ticker }, "Handling '/ticker' request");

    res.status(202).json({ ticker: ticker })
});

app.listen(PORT, () => {
    console.log(`Server is listening at http://localhost:${PORT}`);
});

