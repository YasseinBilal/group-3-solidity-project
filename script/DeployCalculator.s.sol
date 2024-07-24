// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std/Script.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

import "../src/Calculator.sol";
import "../src/CalculatorV2.sol";

contract DeployCalculatorScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PK");
        vm.startBroadcast(deployerPrivateKey);

        address admin = vm.envAddress("admin");

        // Deploy Calculator logic contract
        Calculator calculator = new Calculator();

        // Initialize data
        bytes memory data = abi.encodeWithSelector(
            Calculator.initialize.selector
        );

        // Deploy TransparentUpgradeableProxy
        TransparentUpgradeableProxy proxy = new TransparentUpgradeableProxy(
            address(calculator),
            admin,
            data
        );

        vm.stopBroadcast();

        // Log addresses
        console.log(
            "Calculator logic contract deployed to:",
            address(calculator)
        );
        console.log("TransparentUpgradeableProxy deployed to:", address(proxy));
    }
}
