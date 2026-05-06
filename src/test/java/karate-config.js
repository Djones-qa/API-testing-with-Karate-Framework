function fn() {
  var env = karate.env;
  karate.log('karate.env system property:', env);

  if (!env) {
    env = 'dev';
  }

  var config = {
    env: env,
    baseUrl: 'https://reqres.in/api',
    connectTimeout: 10000,
    readTimeout: 15000
  };

  if (env === 'dev') {
    config.baseUrl = 'https://reqres.in/api';
  } else if (env === 'staging') {
    config.baseUrl = 'https://reqres.in/api';
  } else if (env === 'prod') {
    config.baseUrl = 'https://reqres.in/api';
  }

  karate.configure('connectTimeout', config.connectTimeout);
  karate.configure('readTimeout', config.readTimeout);

  config.utils = karate.call('classpath:helpers/common.feature');

  return config;
}
