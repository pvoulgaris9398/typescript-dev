import express, { type Request, type Response } from 'express';
import pinoHttp from 'pino-http';
import pino from 'pino';
import { createStream } from 'pino-seq';

const app = express();
const PORT = 3000;

// Are we running locally?
const isProduction = process.env.NODE_ENV === 'production';

const seqStream = createStream({
    serverUrl: process.env.SEQ_URL || 'http://localhost:5341',
    //apiKey: process.env.SEQ_API_KEY || 'your-api-key-here',
    maxBatchingTime: 1000, // Send logs every second
    onError: (err) => {
        console.error('Error sending logs to Seq:', err);
    },
});

const logger = pino(
    {
        name: 'artemis-webapi',
        level: process.env.LOG_LEVEL || 'info',
    },
    seqStream
);


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
    logger.info({ currentTicker: ticker }, "Logging '/ticker' request with pino");

    res.status(202).json({ ticker: ticker })
});

app.listen(PORT, () => {
    console.log(`Server is listening at http://localhost:${PORT}`);
});

