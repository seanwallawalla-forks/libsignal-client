//
// Copyright (C) 2020 Signal Messenger, LLC.
// All rights reserved.
//
// SPDX-License-Identifier: GPL-3.0-only
//
// Generated by zkgroup/codegen/codegen.py - do not edit

import Foundation
import SignalFfi

public class ClientZkGroupCipher {

  let groupSecretParams: GroupSecretParams

  public init(groupSecretParams: GroupSecretParams) {
    self.groupSecretParams = groupSecretParams
  }

  public func encryptUuid(uuid: ZKGUuid) throws  -> UuidCiphertext {
    var newContents: [UInt8] = Array(repeating: 0, count: UuidCiphertext.SIZE)

    let ffi_return = FFI_GroupSecretParams_encryptUuid(groupSecretParams.getInternalContentsForFFI(), UInt32(groupSecretParams.getInternalContentsForFFI().count), uuid.getInternalContentsForFFI(), UInt32(uuid.getInternalContentsForFFI().count), &newContents, UInt32(newContents.count))

    if (ffi_return != Native.FFI_RETURN_OK) {
      throw ZkGroupException.ZkGroupError
    }

    do {
      return try UuidCiphertext(contents: newContents)
    } catch ZkGroupException.InvalidInput {
      throw ZkGroupException.AssertionError
    }

  }

  public func decryptUuid(uuidCiphertext: UuidCiphertext) throws  -> ZKGUuid {
    var newContents: [UInt8] = Array(repeating: 0, count: ZKGUuid.SIZE)

    let ffi_return = FFI_GroupSecretParams_decryptUuid(groupSecretParams.getInternalContentsForFFI(), UInt32(groupSecretParams.getInternalContentsForFFI().count), uuidCiphertext.getInternalContentsForFFI(), UInt32(uuidCiphertext.getInternalContentsForFFI().count), &newContents, UInt32(newContents.count))
    if (ffi_return == Native.FFI_RETURN_INPUT_ERROR) {
      throw ZkGroupException.VerificationFailed
    }

    if (ffi_return != Native.FFI_RETURN_OK) {
      throw ZkGroupException.ZkGroupError
    }

    do {
      return try ZKGUuid(contents: newContents)
    } catch ZkGroupException.InvalidInput {
      throw ZkGroupException.AssertionError
    }

  }

  public func encryptProfileKey(profileKey: ProfileKey, uuid: ZKGUuid) throws  -> ProfileKeyCiphertext {
    var newContents: [UInt8] = Array(repeating: 0, count: ProfileKeyCiphertext.SIZE)

    let ffi_return = FFI_GroupSecretParams_encryptProfileKey(groupSecretParams.getInternalContentsForFFI(), UInt32(groupSecretParams.getInternalContentsForFFI().count), profileKey.getInternalContentsForFFI(), UInt32(profileKey.getInternalContentsForFFI().count), uuid.getInternalContentsForFFI(), UInt32(uuid.getInternalContentsForFFI().count), &newContents, UInt32(newContents.count))

    if (ffi_return != Native.FFI_RETURN_OK) {
      throw ZkGroupException.ZkGroupError
    }

    do {
      return try ProfileKeyCiphertext(contents: newContents)
    } catch ZkGroupException.InvalidInput {
      throw ZkGroupException.AssertionError
    }

  }

  public func decryptProfileKey(profileKeyCiphertext: ProfileKeyCiphertext, uuid: ZKGUuid) throws  -> ProfileKey {
    var newContents: [UInt8] = Array(repeating: 0, count: ProfileKey.SIZE)

    let ffi_return = FFI_GroupSecretParams_decryptProfileKey(groupSecretParams.getInternalContentsForFFI(), UInt32(groupSecretParams.getInternalContentsForFFI().count), profileKeyCiphertext.getInternalContentsForFFI(), UInt32(profileKeyCiphertext.getInternalContentsForFFI().count), uuid.getInternalContentsForFFI(), UInt32(uuid.getInternalContentsForFFI().count), &newContents, UInt32(newContents.count))
    if (ffi_return == Native.FFI_RETURN_INPUT_ERROR) {
      throw ZkGroupException.VerificationFailed
    }

    if (ffi_return != Native.FFI_RETURN_OK) {
      throw ZkGroupException.ZkGroupError
    }

    do {
      return try ProfileKey(contents: newContents)
    } catch ZkGroupException.InvalidInput {
      throw ZkGroupException.AssertionError
    }

  }

  public func encryptBlob(plaintext: [UInt8]) throws  -> [UInt8] {
    var randomness: [UInt8] = Array(repeating: 0, count: Int(32))
    let result = SecRandomCopyBytes(kSecRandomDefault, randomness.count, &randomness)
    guard result == errSecSuccess else {
      throw ZkGroupException.AssertionError
    }

    return try encryptBlob(randomness: randomness, plaintext: plaintext)
  }

  public func encryptBlob(randomness: [UInt8], plaintext: [UInt8]) throws  -> [UInt8] {
    let paddedPlaintext = Array(repeating:0, count: 4) + plaintext

    var newContents: [UInt8] = Array(repeating: 0, count: Int(paddedPlaintext.count + 29))

    let ffi_return = FFI_GroupSecretParams_encryptBlobDeterministic(groupSecretParams.getInternalContentsForFFI(), UInt32(groupSecretParams.getInternalContentsForFFI().count), randomness, UInt32(randomness.count), paddedPlaintext, UInt32(paddedPlaintext.count), &newContents, UInt32(newContents.count))
    if (ffi_return == Native.FFI_RETURN_INPUT_ERROR) {
      throw ZkGroupException.VerificationFailed
    }

    if (ffi_return != Native.FFI_RETURN_OK) {
      throw ZkGroupException.ZkGroupError
    }

    return newContents
  }

  public func decryptBlob(blobCiphertext: [UInt8]) throws  -> [UInt8] {
    var newContents: [UInt8] = Array(repeating: 0, count: Int(blobCiphertext.count + -29))

    let ffi_return = FFI_GroupSecretParams_decryptBlob(groupSecretParams.getInternalContentsForFFI(), UInt32(groupSecretParams.getInternalContentsForFFI().count), blobCiphertext, UInt32(blobCiphertext.count), &newContents, UInt32(newContents.count))
    if (ffi_return == Native.FFI_RETURN_INPUT_ERROR) {
      throw ZkGroupException.VerificationFailed
    }

    if (ffi_return != Native.FFI_RETURN_OK) {
      throw ZkGroupException.ZkGroupError
    }

    if newContents.count < 4 {
        throw ZkGroupException.VerificationFailed
    }

    var paddingLen = newContents.withUnsafeBytes({ $0.load(fromByteOffset:0, as: UInt32.self) })
    paddingLen = UInt32(bigEndian: paddingLen)

    if (newContents.count < (4 + paddingLen))  {
        throw ZkGroupException.VerificationFailed
    }

    return Array(newContents[4 ..< newContents.endIndex - Int(paddingLen)])
  }

}
