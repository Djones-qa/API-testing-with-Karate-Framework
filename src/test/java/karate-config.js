function fn() {
  var env = karate.env;
  karate.log('karate.env system property:', env);

  if (!env) {
    env = 'dev';
  }

  var config = {
    env: env,
    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeout: 10000,
    readTimeout: 15000
  };

  karate.configure('connectTimeout', config.connectTimeout);
  karate.configure('readTimeout', config.readTimeout);

  config.utils = karate.call('classpath:helpers/common.feature');

  return config;
}
