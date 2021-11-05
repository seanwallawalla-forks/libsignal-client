//
// Copyright 2021 Signal Messenger, LLC.
// SPDX-License-Identifier: AGPL-3.0-only
//

import ByteArray from '../internal/ByteArray';
import NativeImpl from '../../NativeImpl';
import ReceiptSerial from './ReceiptSerial';

export default class ReceiptCredentialPresentation extends ByteArray {
  static SIZE = 329;

  constructor(contents: Buffer) {
    super(
      contents,
      NativeImpl.ReceiptCredentialPresentation_CheckValidContents
    );
  }

  getReceiptExpirationTime(): bigint {
    return NativeImpl.ReceiptCredentialPresentation_GetReceiptExpirationTime(
      this.contents
    ).readBigUInt64BE();
  }

  getReceiptLevel(): bigint {
    return NativeImpl.ReceiptCredentialPresentation_GetReceiptLevel(
      this.contents
    ).readBigUInt64BE();
  }

  getReceiptSerialBytes(): ReceiptSerial {
    return new ReceiptSerial(
      NativeImpl.ReceiptCredentialPresentation_GetReceiptSerial(this.contents)
    );
  }
}