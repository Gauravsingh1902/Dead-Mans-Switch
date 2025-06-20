const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying contract with the account:", deployer.address);

  const DeadMansSwitch = await hre.ethers.getContractFactory("DeadMansSwitch");

  // Set the beneficiary and timeout period (in seconds, e.g., 1 week)
  const beneficiary = "0xYourBeneficiaryAddressHere";
  const timeoutPeriod = 604800; // 7 days in seconds

  const contract = await DeadMansSwitch.deploy(beneficiary, timeoutPeriod);

  await contract.deployed();

  console.log("DeadMansSwitch deployed to:", contract.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
