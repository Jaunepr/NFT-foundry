// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";

contract DeployMoodNftTest is Test {
    DeployMoodNft public deployer;
    string public constant exampleUri =
        "data:application/json;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj4KICAgIDx0ZXh0IHg9IjAiIHk9IjE1IiBmaWxsPSJyZWQiPkhlbGxvIEphdW5lcHIhIFlvdXIgZnVja2luZyBzaGl0ITwvdGV4dD4KPC9zdmc+";

    // string public svgUri;

    function setUp() public {
        deployer = new DeployMoodNft();
    }

    function testSvgToUri() public {
        string
            memory exampleUri = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj48dGV4dCB4PSIwIiB5PSIxNSIgZmlsbD0icmVkIj5IZWxsbyBKYXVuZXByISBZb3VyIGZ1Y2tpbmcgc2hpdCE8L3RleHQ+PC9zdmc+";
        string
            memory svg = '<svg xmlns="http://www.w3.org/2000/svg" width="500" height="500"><text x="0" y="15" fill="red">Hello Jaunepr! Your fucking shit!</text></svg>';
        string memory actualUri = deployer.svgToImgUri(svg);
        assert(
            keccak256(abi.encodePacked(exampleUri)) ==
                keccak256(abi.encodePacked(actualUri))
        );
    }
}
