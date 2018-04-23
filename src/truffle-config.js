/*
Modified to work with Ganache as previously this file was empty and Ganache couldn't be accessed
*/
module.exports = {
   networks: {
   development: {
   host: "localhost",
   port: 7545,
   network_id: "*" // Match any network id
  }
 }
};
