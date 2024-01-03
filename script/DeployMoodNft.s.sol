// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Script, console} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft) {
        string memory sadSvg = vm.readFile("./img/sad.svg");
        string memory happySvg = vm.readFile("./img/happy.svg");
        // console.log(sadSvg);
        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(
            svgToImgUri(sadSvg),
            svgToImgUri(happySvg)
        );
        vm.stopBroadcast();
        return moodNft;
    }

    function svgToImgUri(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseUri = "data:image/svg+xml;base64,";
        string memory svgUriBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        return string.concat(baseUri, svgUriBase64Encoded);
    }
}
