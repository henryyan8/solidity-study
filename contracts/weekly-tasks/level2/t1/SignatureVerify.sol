// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SigatureVerify {
    // address private pri_key=0x227dbb8586117d55284e26620bc76534dfbd2394be34cf4a09cb775d593b6f2b;
    // address private pub_key=0xe16C1623c1AA7D919cd2241d8b36d9E79C1Be2A2;

    /*
     * 将mint地址（address类型）和tokenId（uint256类型）拼成消息msgHash
     * _account: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
     * _tokenId: 0
     * 对应的消息msgHash: 0x1bf2c0ce4546651a1a2feb457b39d891a6b83931cc2454434f39961345ac378c
     */
    function getMessageHash(address _account,uint256 _tokenid) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_account,_tokenid));
    }

    /**
     * @dev 返回 以太坊签名消息
     * `hash`：消息
     * 遵从以太坊签名标准：https://eth.wiki/json-rpc/API#eth_sign[`eth_sign`]
     * 以及`EIP191`:https://eips.ethereum.org/EIPS/eip-191`
     * 添加"\x19Ethereum Signed Message:\n32"字段，防止签名的是可执行交易。
     */
    function toEthSignedMessageHash(bytes32 hash) public pure returns (bytes32) {
        // 哈希的长度为32
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
    }

    // @dev 从_msgHash和签名_signature中恢复signer地址
    function recoverSigner(bytes32 _msgHash,bytes memory _signature) public pure returns(address) {
        require(_signature.length==65,"invalid signature length");
        bytes32 r;
        bytes32 s;
        uint8 v;
        assembly {
            r:=mload(add(_signature,0x20))
            s:=mload(add(_signature,0x40))
            v:=byte(0,mload(add(_signature,0x60)))
        }
        return ecrecover(_msgHash, v, r, s);
    }
    
    /**
     * @dev 通过ECDSA，验证签名地址是否正确，如果正确则返回true
     * _msgHash为消息的hash
     * _signature为签名
     * _signer为签名地址
     */
    function verify(bytes32 _msgHash, bytes memory _signature, address _signer) public pure returns (bool) {
        return recoverSigner(_msgHash, _signature) == _signer;
    }
}