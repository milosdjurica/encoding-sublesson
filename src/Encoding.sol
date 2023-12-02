// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

contract Encoding {
    function combineStrings() public pure returns (string memory) {
        // combining bytes of those 2 strings, and then casting bytes into string with string() around it
        // this does the same thing as string.concat("Hello ", "there");
        return string(abi.encodePacked("Hello ", "there!"));
    }

    function encodeNumber() public pure returns (bytes memory) {
        bytes memory number = abi.encode(1);
        return number;
    }

    function encodeString() public pure returns (bytes memory) {
        return abi.encode("Encoded string");
    }

    function encodeStringPacked() public pure returns (bytes memory) {
        // encodePacked is much more gas efficient, but less precise
        bytes memory someString = abi.encodePacked(
            "Encoded string, but 'compresses it'!!!"
        );

        return someString;
    }

    // this and encodePacked() are very similar, but they do diff things
    // read more about it here -> // https://forum.openzeppelin.com/t/difference-between-abi-encodepacked-string-and-bytes-string/11837
    function encodeStringBytes() public pure returns (bytes memory) {
        bytes memory someString = bytes("Cast string into bytes");
        return someString;
    }

    function decodeString() public pure returns (string memory) {
        string memory someString = abi.decode(encodeString(), (string));
        return someString;
    }

    function multiEncode() public pure returns (bytes memory) {
        bytes memory someString = abi.encode("some string ", "with addition");
        return someString;
    }

    function multiDecode() public pure returns (string memory, string memory) {
        (string memory someString, string memory secondString) = abi.decode(
            multiEncode(),
            (string, string)
        );
        return (someString, secondString);
    }

    function multiEncodePacked() public pure returns (bytes memory) {
        bytes memory someString = abi.encodePacked(
            "some string",
            " second string"
        );
        return someString;
    }

    // ! THIS DOESNT WORK !!!!
    function multiDecodePacked() public pure returns (string memory) {
        string memory someString = abi.decode(multiEncodePacked(), (string));
        return someString;
    }

    // ! This works! Because encodePacked() is "similar" to type casting
    function multiStringCastPacked() public pure returns (string memory) {
        string memory someString = string(multiEncodePacked());
        return someString;
    }
}
