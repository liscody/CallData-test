// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract MyCalldataTest {

    // return selectore of the function 

    function selector () external pure returns (bytes4) {
        return bytes4(
            keccak256(
                bytes(
                    "testCallDataStorage(uint256[3])"
                    )));
            // bytes4: 0x43d19674

        }
        
    function testCallDataStorageString(string calldata _str) external pure returns (bytes32 _el1) {
        assembly {
            //_el1 := calldataload(4)
           // _el1 := calldataload(add(4,32))
           _el1 := calldataload(add(4, 64))
        }
        // for string it is saved in another way 
        // note 
        // 20 is equal 32 
        // 32 byte is begin information about string 
        // 4 it is a how long a string in bytes 
        //
        // bytes32: _el1 0x0000000000000000000000000000000000000000000000000000000000000020
        //
        // bytes32: _el1 0x0000000000000000000000000000000000000000000000000000000000000004
    }      


        function testCallDataStorage2(uint[3] calldata _arr) external pure returns (bytes32 _el1) {
        
        assembly {
            _el1 := calldataload(4)
        }
        // bytes32: _el1 0x0000000000000000000000000000000000000000000000000000000000000001
    }    

        function testCallDataDynamicArray(uint[] memory _arr) external pure returns (
            bytes32 _startIn,  bytes32 _elCount,  bytes32 _firstEl) 
        {
            assembly{
                _startIn:= calldataload(4)
                _elCount:= calldataload(add(_startIn, 4))
                _firstEl:= calldataload(add(_startIn, 36))
            }

                // 0: bytes32: _startIn 0x0000000000000000000000000000000000000000000000000000000000000020
                // 1: bytes32: _elCount 0x0000000000000000000000000000000000000000000000000000000000000003
                // 2: bytes32: _firstEl 0x0000000000000000000000000000000000000000000000000000000000000001

    }    
       
    function testCallDataStorage(uint[3] memory _arr) external pure returns (bytes memory) {
           // return bytes4(msg.data[0:4]);/// that is exacly a call data 
            return bytes(msg.data);/// that is exacly a call data 
            
            //  bytes: 0x43d19674
            //0000000000000000000000000000000000000000000000000000000000000001
            //0000000000000000000000000000000000000000000000000000000000000002
            //0000000000000000000000000000000000000000000000000000000000000003
    }     
       
        function testStorage (string memory _str) external pure returns (uint ptr) {
        assembly {
            ptr := mload(64)

            //  ptr 192
        }
    }     
    
    function testByteStorage (string memory _str) external pure returns (bytes32 data) {
        assembly {
           let ptr := mload(64)
           data := mload(sub(ptr, 32))

           // data 0x7465737400000000000000000000000000000000000000000000000000000000   
        }
    } 
    function testArrayStorage (uint[3] memory _arr) external pure returns (bytes32 data) {
        assembly {
           let ptr := mload(64)
           data := mload(sub(ptr, 32))

           //  data 0x0000000000000000000000000000000000000000000000000000000000000003
        }
    } 

    function bytes32ToString(bytes32 _bytes32) public pure returns (string memory) {
        uint8 i = 0;
        while(i < 32 && _bytes32[i] != 0) {
            i++;
        }
        bytes memory bytesArray = new bytes(i);
        for (i = 0; i < 32 && _bytes32[i] != 0; i++) {
            bytesArray[i] = _bytes32[i];
        }
        return string(bytesArray);
    }
    
    
    function bytesToUint(bytes memory b) public pure returns (uint256){
        uint256 number;
        for(uint i=0;i<b.length;i++){
            number = number + uint(uint8(b[i]))*(2**(8*(b.length-(i+1))));
        }
        return number;
    }
    
    function stringToBytes(string memory _str)  public pure returns  (bytes memory){
        bytes memory b3 = bytes(_str );
        return b3;
    }

}