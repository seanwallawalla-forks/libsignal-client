//
// Copyright (C) 2020 Signal Messenger, LLC.
// All rights reserved.
//
// SPDX-License-Identifier: GPL-3.0-only
//
// Generated by zkgroup/codegen/codegen.py - do not edit

import Foundation
import SignalFfi

public class ProfileKeyCredentialRequestContext : ByteArray {

  public static let SIZE: Int = 473

  public init(contents: [UInt8]) throws  {
    try super.init(newContents: contents, expectedLength: ProfileKeyCredentialRequestContext.SIZE)

    
    let ffi_return = FFI_ProfileKeyCredentialRequestContext_checkValidContents(self.contents, UInt32(self.contents.count))

    if (ffi_return == Native.FFI_RETURN_INPUT_ERROR) {
      throw ZkGroupException.InvalidInput
    }

    if (ffi_return != Native.FFI_RETURN_OK) {
      throw ZkGroupException.ZkGroupError
    }
  }

  public func getRequest() throws  -> ProfileKeyCredentialRequest {
    var newContents: [UInt8] = Array(repeating: 0, count: ProfileKeyCredentialRequest.SIZE)

    let ffi_return = FFI_ProfileKeyCredentialRequestContext_getRequest(self.contents, UInt32(self.contents.count), &newContents, UInt32(newContents.count))

    if (ffi_return != Native.FFI_RETURN_OK) {
      throw ZkGroupException.ZkGroupError
    }

    do {
      return try ProfileKeyCredentialRequest(contents: newContents)
    } catch ZkGroupException.InvalidInput {
      throw ZkGroupException.AssertionError
    }

  }

  public func serialize() -> [UInt8] {
    return contents
  }

}
