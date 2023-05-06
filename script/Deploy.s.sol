// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.19;

import {CREATE3Script} from "./base/CREATE3Script.sol";
import {ERC20V3Factory} from "../src/ERC20V3Factory.sol";

contract DeployScript is CREATE3Script {
    constructor() CREATE3Script(vm.envString("VERSION")) {}

    function run() external returns (ERC20V3Factory e) {
        uint256 deployerPrivateKey = uint256(vm.envBytes32("PRIVATE_KEY"));

        uint256 param = 123;

        vm.startBroadcast(deployerPrivateKey);

        address payable erc20V3FactoryAddr = payable(
            create3.deploy(
                getCreate3ContractSalt("Counter"), bytes.concat(type(ERC20V3Factory).creationCode, abi.encode(param))
            )
        );

        vm.stopBroadcast();

        e = ERC20V3Factory(erc20V3FactoryAddr);
    }
}
