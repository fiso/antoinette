const axios = require('axios');
const express = require('express');
const {promisify} = require('util');
const redis = require('redis');

const app = express();
const remote = 'https://antoinette.stage.akademi.agency/wp-json/antoinette';

const useRedis = false;
const client = useRedis
  ? redis.createClient()
  : {
    get: (_, cb) => cb(),
    set: () => null,
  };

const getAsync = promisify(client.get).bind(client);

async function callApi (url) {
  let result = {};
  try {
    const r = await axios.get(`${remote}${url}`);
    result = {
      status: r.status,
      data: r.data,
    };
  } catch (e) {
    result = {
      status: e.response.status,
      data: e.response.data,
    };
  } finally {
    client.set(url, JSON.stringify(result), 'EX', 60 * 10);
    return result;
  }
}

app.get('*', async (req, res) => {
  const url = req.originalUrl.replace(/^\/api/, '');
  const cached = await getAsync(url);

  console.log('>>', url);
  console.log(cached ? 'HIT' : 'MISS');

  const response = cached
    ? JSON.parse(cached)
    : await callApi(url);

  res.status(response.status).send(response.data);
});

app.listen(3000);
