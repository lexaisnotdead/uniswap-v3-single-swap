const SingleSwap = artifacts.require("SingleSwap");

module.exports = async function (deployer) {
    await deployer.deploy(SingleSwap);
}