const ConvertLib = artifacts.require("ConvertLib");
const Insurance = artifacts.require("Insurance");

module.exports = function(deployer) {

  deployer.deploy(Insurance);
};
