[![NPM Package](https://img.shields.io/npm/v/@confluxfans/contracts.svg)](https://www.npmjs.org/package/@confluxfans/contracts)

# conflux-contracts
Common useful contracts in Conflux DAPP developments. Code

* Conflux internal contracts
* Support Solidity 8.0+, depend on @openzeppelin/contracts 4.0+


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


## Contribute
There are many ways you can participate and help build high quality software. Check out the [contribution](./CONTRIBUTING.md) guide!

### Compile & Lint

```sh
$ npm run lint
$ npm run lint:sol:fix  # run this command if lint failed to fix code style issue
$ npm run compile  # or npx hardhat compile
```


### How to release version

1. Update `version` field in project root's `package.json` and then run `npm run version` to sync sub folder's (`contracts`) `package.json`
2. cd `contracts` folder
3. Run `npm publish --access public` to publish package.


## License

Conflux-contracts is released under the [MIT License](LICENSE).