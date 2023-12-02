// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

contract CallAnything {
    address public s_someAddress;
    uint public s_amount;

    function transfer(address someAddress, uint amount) public {
        s_someAddress = someAddress;
        s_amount = amount;
    }

    function getSelectorOne() public pure returns (bytes4 selector) {
        selector = bytes4(keccak256(bytes("transfer(address,uint)")));
    }

    function getDataToCallTransfer(
        address someAddress,
        uint amount
    ) public pure returns (bytes memory) {
        return abi.encodeWithSelector(getSelectorOne(), someAddress, amount);
    }

    function callTransferFunctionWithBinary1(
        address someAddress,
        uint amount
    ) public returns (bytes4, bool) {
        (bool success, bytes memory returnData) = address(this).call(
            getDataToCallTransfer(someAddress, amount)
            // abi.encodeWithSelector(getSelectorOne(), someAddress, amount)
            // abi.encodeWithSignature(
            //     "transfer(address,uint)",
            //     someAddress,
            //     amount
            // )
        );
        return (bytes4(returnData), success);
    }

    function callTransferFunctionWithBinary2(
        address someAddress,
        uint amount
    ) public returns (bytes4, bool) {
        (bool success, bytes memory returnData) = address(this).call(
            // getDataToCallTransfer(someAddress, amount)
            abi.encodeWithSelector(getSelectorOne(), someAddress, amount)
            // abi.encodeWithSignature(
            //     "transfer(address,uint)",
            //     someAddress,
            //     amount
            // )
        );
        return (bytes4(returnData), success);
    }

    function callTransferFunctionWithBinary3(
        address someAddress,
        uint amount
    ) public returns (bytes4, bool) {
        (bool success, bytes memory returnData) = address(this).call(
            // getDataToCallTransfer(someAddress, amount)
            // abi.encodeWithSelector(getSelectorOne(), someAddress, amount)
            abi.encodeWithSignature(
                "transfer(address,uint)",
                someAddress,
                amount
            )
        );
        return (bytes4(returnData), success);
    }
}
