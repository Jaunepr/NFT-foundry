// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Test, console} from "forge-std/Test.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {BasicNft} from "../../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address private USER = makeAddr("Murph");
    string public constant s_URI =
        "ipfs://QmPskcR4Mwc26mRh4iijAoDPR6awQVdM6Ap27ArPQM8zXW?filename=Barzinga.jpg";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Jaunepr";
        string memory actualName = basicNft.name();
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testMintNftAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(s_URI);
        assert(
            keccak256(abi.encodePacked(s_URI)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
        assert(basicNft.balanceOf(USER) == 1);
    }
}
