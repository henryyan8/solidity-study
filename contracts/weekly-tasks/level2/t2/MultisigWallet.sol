// SPDX-License-Identifier: MIT
/**
多签钱包、AA 钱包.
极简版多签钱包
Author:yanht
**/
pragma solidity ^0.8.25;

contract MultisigWallet{
    address[] public owners;// 多签持有人数组 
    mapping(address=>bool) public isOwner;// 记录一个地址是否为多签持有人
    uint256 public ownerCount;// 多签持有人数量
    uint256 public threshold;// 多签执行门槛，交易至少有n个多签人签名才能被执行。
    uint256 public nonce;// nonce，防止签名重放攻击

    event ExecutionSuccess(bytes32 txHash);// 交易成功事件
    event ExecutionFailure(bytes32 txHash);// 交易失败事件

    constructor(address[] memory _owners,uint256 _threshold){
        _setupOwners(_owners, _threshold);
    }

    // @dev 初始化owners, isOwner, ownerCount,threshold 
    // @param _owners: 多签持有人数组
    // @param _threshold: 多签执行门槛，至少有几个多签人签署了交易
    function _setupOwners(address[] memory _owner,uint256 _threshold) internal {
    // threshold没被初始化过
        require(threshold==0,"DQ5000");
    // 多签执行门槛 小于 多签人数
        require(_threshold<=_owner.length,"DQ5001");
    // 多签执行门槛至少为1
        require(_threshold>=1,"DQ5002");
        for(uint256 i=0;i<_owner.length;i++){
            address owner=_owner[i];
        // 多签人不能为0地址，本合约地址，不能重复
            require(owner!=address(0) && owner!=address(this) && !isOwner[owner],"DQ5003");
            owners.push(owner);
            isOwner[owner]=true;
        }
        ownerCount=_owner.length;
        threshold=_threshold;
    }

/// @dev 在收集足够的多签签名后，执行交易
/// @param to 目标合约地址
/// @param value msg.value，支付的以太坊
/// @param data calldata
/// @param signatures 打包的签名，对应的多签地址由小到达，方便检查。 ({bytes32 r}{bytes32 s}{uint8 v}) (第一个多签的签名, 第二个多签的签名 ... )
    function execTransaction(address to,uint256 value,bytes memory data,bytes memory signatures) 
    public payable virtual returns(bool success){
        bytes32 txHash=encodeTransactionData(to, value, data, nonce, block.chainid);
        nonce++;
        checkSignatures(txHash, signatures);
        (success,)=to.call{value:value}(data);
        //require(success,"DQ5004");
        if(success) emit ExecutionSuccess(txHash);
        else emit ExecutionFailure(txHash);
    }

    /**
    * @dev 检查签名和交易数据是否对应。如果是无效签名，交易会revert
    * @param dataHash 交易数据哈希
    * @param signatures 几个多签签名打包在一起
    */
    function checkSignatures(bytes32 dataHash, bytes memory signatures) public view{
        uint256 _threshold=threshold;
        require(_threshold>0,"DQ5005");
        require(signatures.length>=_threshold*65,"DQ5006");
        address lastOwner=address(0);
        address curentOwner;
        bytes32 r;
        bytes32 s;
        uint8 v;
        for(uint256 i=0;i<_threshold;i++){
            (v,r,s)=signatureSplit(signatures, i);
            curentOwner=ecrecover(keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32",dataHash)), v, r, s);
            require(curentOwner>lastOwner && isOwner[curentOwner],"DQ5007");
            lastOwner=curentOwner;
        }
    }

/// 将单个签名从打包的签名分离出来
/// @param signatures 打包签名
/// @param pos 要读取的多签index.
    function signatureSplit(bytes memory signatures,uint256 pos) internal pure returns(uint8 v,bytes32 r,bytes32 s){
        assembly{
            let signaturePos:=mul(0x41,pos)
            r:=mload(add(signatures,add(signaturePos,0x20)))
            s:=mload(add(signatures,add(signaturePos,0x40)))
            v:=and(mload(add(signatures,add(signaturePos,0x41))),0xff)
        }
    }

/// @dev 编码交易数据
/// @param to 目标合约地址
/// @param value msg.value，支付的以太坊
/// @param data calldata
/// @param _nonce 交易的nonce.
/// @param chainid 链id
/// @return 交易哈希bytes.
    function encodeTransactionData(address to,uint256 value,bytes memory data,uint256 _nonce,uint256 chainid)
    public pure returns(bytes32){
        bytes32 safeTxHash=keccak256(abi.encode(to,value,keccak256(data),_nonce,chainid));
        return safeTxHash;
    }
}