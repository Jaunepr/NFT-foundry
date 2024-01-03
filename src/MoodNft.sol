// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    //error
    error MoodNft__cantChangeMoodIfNotOwner();

    uint256 private s_tokenCounter;
    string private s_sadSvgImgUri;
    string private s_happySvgImgUri;

    enum Mood {
        HAPPY,
        SAD
    }
    mapping(uint256 tokenId => Mood) private s_tokenIdToMood;

    constructor(
        string memory sadSvgImgUri,
        string memory happySvgImgUri
    ) ERC721("MoodNft", "MOD") {
        s_tokenCounter = 0;
        s_sadSvgImgUri = sadSvgImgUri;
        s_happySvgImgUri = happySvgImgUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenId) public view {
        if (
            getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender
        ) {
            revert MoodNft__cantChangeMoodIfNotOwner();
        }

        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] == Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] == Mood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenUri(uint256 tokenId) public view returns (string memory) {
        string memory imageUri;
        string memory tokenMetaData;

        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageUri = s_happySvgImgUri;
        } else {
            imageUri = s_sadSvgImgUri;
        }

        tokenMetaData = string.concat(
            _baseURI(),
            Base64.encode(
                bytes(
                    string.concat(
                        '{"name:"',
                        name(),
                        '"description: A NFT that reflect the owners mood,"',
                        '"attributes": [{"trait_type":"moodness","value": 100}],',
                        '"images":',
                        imageUri,
                        "}"
                    )
                )
            )
        );
        return tokenMetaData;
        // {"name": "MoodNFT"}
    }
}
