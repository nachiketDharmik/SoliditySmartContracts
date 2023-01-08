// scripts/deploy.js
async function main() {
    // this id the proxy address that we get when we run deploy.js file earlier
   // const proxyAddress = '0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0';
   const Box = await ethers.getContractFactory("Box");
  console.log("Deploying proxy , box implem,entation , and proxy admin...");
  const boxProxy = await upgrades.deployProxy(Box, [42], { initializer: 'store' });
  console.log("BoxProxy deployed to:", boxProxy.address); 
   const BoxV2 = await ethers.getContractFactory("BoxV2");
    console.log("upgrading implementation.....");
    const newImplementationAddress = await upgrades.upgradeProxy(boxProxy.address ,BoxV2 );
    console.log("New Implementation Address:", newImplementationAddress);
  }
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });