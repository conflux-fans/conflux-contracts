# conflux-contracts
Common useful contracts in Conflux DAPP developments. Code

* Conflux internal contracts


## Overview

### Install
```sh
$ npm install @confluxfans/contracts
```

### How to Use
```js
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@confluxfans/contracts/InternalContracts/AdminControl.sol";

contract YourContract {
  AdminControl adminControl = AdminControl(0x0888000000000000000000000000000000000000);
  
  constructor() public {
  }
}
```


## License

Conflux-contracts is released under the [MIT License](LICENSE).