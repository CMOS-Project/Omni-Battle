const AlienSpawner = artifacts.require('./AlienSpawner.sol');
const AlienOwnership  = artifacts.require('./AlienOwnership.sol');
const TokenStandard = artifacts.require('./TokenStandard.sol');
const AlienStatistics = artifacts.require('./AlienStatistics.sol');

module.exports = function(deployer) {
  deployer.deploy(AlienSpawner);
  deployer.deploy(AlienOwnership);
  deployer.deploy(TokenStandard);
  deployer.deploy(AlienStatistics);
};
