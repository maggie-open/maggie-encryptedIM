# maggie-encryptedIM
Maggie P2P encrypted IM module

## Introduction
Maggie APP has a built-in encrypted IM module, which is based on PKI encryption mechanism and third-party IM service provided by *Easemob*. This project contains correlative iOS APP code.

## Architecture
As a social platform with attributes of strong authentication and high privacy, Maggie has designed an **encrypted IM mechanism** to fully protect user’s privacy. 
<br/>
<div align="center">
  <img src="https://github.com/maggie-open/maggie-encryptedIM/blob/master/pictures/archi_IM.png" width = "655" height = "439" alt="EncryptedIM_Arch" />
</div>
<br/>
User’s private key, which is the most important for privacy, will be generated and stored only at user’s cellphone. Private key will never be sent to server and has to be kept by user himself just like in a **block chain system**. For example, in iOS, user’s private key and certificate will kept in the Keychain, which has a higher secure level than other application storages.
<br/><br/>
Maggie will generate a symmetric key and transfer it between two users for their encrypted P2P session, using **PKI** encryption mechanism.
<br/>

## Encrypted IM Process
An encrypted P2P IM process is accomplished in Maggie APP as below:
<br/>
<div align="center">
  <img src="https://github.com/maggie-open/maggie-encryptedIM/blob/master/pictures/proc_IM.png" width = "650" height = "532" alt="EncryptedIM_Arch" />
</div>
<br/>
<ol>
<li><p>User <i>A</i> sends a request for encrypted IM with <i>B</i></p></li>
<li><p>User <i>B</i> accepts the request</p></li>
<li><p><i>A</i> sends request to server to apply for the public key of <i>B</i></p></li>
<li><p><i>A</i> gets <i>B</i>’s public key, generates a symmetric session key, and encrypts it with public key of <i>B</i></p></li>
<li><p><i>A</i> signs a verification information with his private key, and send it to <i>B</i></p></li>
<li><p><i>B</i> receives the encrypted session key and verification information, decrypts the session key with his private key, and verifies the signed information with <i>A</i>’s public key</p></li>
<li><p>User <i>A</i> and <i>B</i> both enter encrypted IM and start a chat</p></li>
</ol>