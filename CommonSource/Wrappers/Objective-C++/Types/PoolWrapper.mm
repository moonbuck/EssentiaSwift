//
//  PoolWrapper.mm
//  Essentia
//
//  Created by Jason Cardwell on 10/11/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import "PoolWrapper.h"
#import "NSArray+BridgingExtensions.hpp"
#import "NSDictionary+BridgingExtensions.hpp"
#import "WrappedTypes.hpp"
#import "PoolWrapper+BridgingExtensions.hpp"
#import "NSValue+BridgingExtensions.h"
#import "NSString+BridgingExtensions.hpp"

using namespace essentia;
using namespace std;

@implementation PoolWrapper

/**
 Initializing by creating a new instance of `Pool`.

 @return The newly intialized wrapper for a newly created pool.
 */
- (nonnull instancetype)init {
  self = [super init];
  if (self) {
    _pool = make_shared<Pool>();
  }
  return self;
}

/**
 Initializing with an existing C++ `Pool`.

 @param pool The C++ `Pool` to wrap.
 @return The newly initialized wrapper for `pool`.
 */
- (nonnull instancetype)initWithPool:(Pool *)pool {
  self = [super init];
  if (self) {
    _pool = make_shared<Pool>(*pool);
  }
  return self;
}

/**
 Creates a new wrapper for an existing C++ `Pool`.

 @param pool The C++ `Pool` to wrap.
 @return The newly created wrapper for `pool`.
 */
+ (nonnull instancetype)poolWrapperWithPool:(Pool *)pool {
  return [[PoolWrapper alloc] initWithPool:pool];
}

/**
 Adds a value to the wrapped pool for the specified name.

 If `name` already exists in the pool and points to data with the same data type as `realValue`,
 then `realValue` is concatenated to the vector stored therein. If, however, `name` already exists
 in the pool and points to a different data type than `realValue`, then this can cause unwanted
 behavior for the rest of the member functions of pool. To avoid this, do not add data into the
 pool whose descriptor name already exists in the pool and points to a different data type than
 `realValue`.

 If `name` has child descriptor names, this function will throw an exception. For example, if
 "foo.bar" exists in the pool, this function can no longer be called with "foo" as its `name`
 parameter, because "bar" is a child descriptor name of "foo".

 @param realValue The value to add to the collection of data for `name`.
 @param name A descriptor name identifying the collection to which to add `realValue`.
 */
- (void)addRealValue:(nonnull OBJCReal)realValue forName:(nonnull OBJCString)name {
  _pool->add(name.cppString, realValue.floatValue);
}

/**
 Adds a value to the wrapped pool for the specified name.

 If `name` already exists in the pool and points to data with the same data type as
 `realVecValue`, then `realVecValue` is concatenated to the vector stored therein. If,
 however, `name` already exists in the pool and points to a different data type than
 `realVecValue`, then this can cause unwanted behavior for the rest of the member functions
 of pool. To avoid this, do not add data into the pool whose descriptor name already exists in
 the pool and points to a different data type than `realVecValue`.

 If `name` has child descriptor names, this function will throw an exception. For example, if
 "foo.bar" exists in the pool, this function can no longer be called with "foo" as its `name`
 parameter, because "bar" is a child descriptor name of "foo".

 @param realVecValue The value to add to the collection of data for `name`.
 @param name A descriptor name identifying the collection to which to add `realVecValue`.
 */
- (void)addRealVecValue:(nonnull OBJCRealVec)realVecValue
                  forName:(nonnull OBJCString)name
{
  _pool->add(name.cppString, realVecValue.realVecValue);
}

/**
 Adds a value to the wrapped pool for the specified name.

 If `name` already exists in the pool and points to data with the same data type as `stringValue`,
 then `stringValue` is concatenated to the vector stored therein. If, however, `name` already exists
 in the pool and points to a different data type than `stringValue`, then this can cause unwanted
 behavior for the rest of the member functions of pool. To avoid this, do not add data into the
 pool whose descriptor name already exists in the pool and points to a different data type than
 `stringValue`.

 If `name` has child descriptor names, this function will throw an exception. For example, if
 "foo.bar" exists in the pool, this function can no longer be called with "foo" as its `name`
 parameter, because "bar" is a child descriptor name of "foo".

 @param stringValue The value to add to the collection of data for `name`.
 @param name A descriptor name identifying the collection to which to add `stringValue`.
 */
- (void)addStringValue:(nonnull OBJCString)stringValue forName:(nonnull OBJCString)name {
  _pool->add(name.cppString, stringValue.cppString);
}

/**
 Adds a value to the wrapped pool for the specified name.

 If `name` already exists in the pool and points to data with the same data type as
 `stringVecValue`, then `stringVecValue` is concatenated to the vector stored therein. If,
 however, `name` already exists in the pool and points to a different data type than
 `stringVecValue`, then this can cause unwanted behavior for the rest of the member functions
 of pool. To avoid this, do not add data into the pool whose descriptor name already exists in the
 pool and points to a different data type than `stringVecValue`.

 If `name` has child descriptor names, this function will throw an exception. For example, if
 "foo.bar" exists in the pool, this function can no longer be called with "foo" as its `name`
 parameter, because "bar" is a child descriptor name of "foo".

 @param stringVecValue The value to add to the collection of data for `name`.
 @param name A descriptor name identifying the collection to which to add `stringVecValue`.
 */
- (void)addStringVecValue:(nonnull OBJCStringVec)stringVecValue
                    forName:(nonnull OBJCString)name
{
  _pool->add(name.cppString, stringVecValue.stringVecValue);
}

/**
 Adds a value to the wrapped pool for the specified name.

 If `name` already exists in the pool and points to data with the same data type as
 `realMatrixValue`, then `realMatrixValue` is concatenated to the vector stored therein. If,
 however, `name` already exists in the pool and points to a different data type than
 `realMatrixValue`, then this can cause unwanted behavior for the rest of the member functions
 of pool. To avoid this, do not add data into the pool whose descriptor name already exists in
 the pool and points to a different data type than `realMatrixValue`.

 If `name` has child descriptor names, this function will throw an exception. For example, if
 "foo.bar" exists in the pool, this function can no longer be called with "foo" as its `name`
 parameter, because "bar" is a child descriptor name of "foo".

 @param realMatrixValue The value to add to the collection of data for `name`.
 @param name A descriptor name identifying the collection to which to add `realMatrixValue`.
 */
- (void)addRealMatrixValue:(nonnull OBJCRealMatrix)realMatrixValue
                  forName:(nonnull OBJCString)name
{
  _pool->add(name.cppString, realMatrixValue.realMatrixValue);
}

/**
 Adds a value to the wrapped pool for the specified name.

 If `name` already exists in the pool and points to data with the same data type as
 `stereoSampleValue`, then `stereoSampleValue` is concatenated to the vector stored therein.
 If, however, `name` already exists in the pool and points to a different data type than
 `stereoSampleValue`, then this can cause unwanted behavior for the rest of the member functions
 of pool. To avoid this, do not add data into the pool whose descriptor name already exists in
 the pool and points to a different data type than `stereoSampleValue`.

 If `name` has child descriptor names, this function will throw an exception. For example, if
 "foo.bar" exists in the pool, this function can no longer be called with "foo" as its `name`
 parameter, because "bar" is a child descriptor name of "foo".

 @param stereoSampleValue The value to add to the collection of data for `name`.
 @param name A descriptor name identifying the collection to which to add `stereoSampleValue`.
 */
- (void)addStereoSampleValue:(nonnull OBJCStereoSample)stereoSampleValue
                    forName:(nonnull OBJCString)name
{
  struct _StereoSample sampleStruct = stereoSampleValue.stereoSampleValue;
  StereoSample stereoSample = {sampleStruct.left, sampleStruct.right};
  _pool->add(name.cppString, stereoSample);
}

/**
 Sets the value of a descriptor name.

 This function is different than the add functions because set does not append data to the
 existing data under a given descriptor name, it sets it. Thus there can only be one datum
 associated with a descriptor name introduced to the pool via the set function. This function is
 useful when there is only one value associated with a given descriptor name.

 The set function cannot be used to override the data of a descriptor name that was introduced
 to the Pool via the add function. An EssentiaException will be thrown if the given descriptor
 name already exists in the pool and was put there via a call to an add function.

 @param realValue The datum to associate with `name`.
 @param name The descriptor name of the datum to set.
 */
- (void)setRealValue:(nonnull OBJCReal)realValue forName:(nonnull OBJCString)name {
  _pool->set(name.cppString, realValue.floatValue);
}

/**
 Sets the value of a descriptor name.

 This function is different than the add functions because set does not append data to the
 existing data under a given descriptor name, it sets it. Thus there can only be one datum
 associated with a descriptor name introduced to the pool via the set function. This function is
 useful when there is only one value associated with a given descriptor name.

 The set function cannot be used to override the data of a descriptor name that was introduced
 to the Pool via the add function. An EssentiaException will be thrown if the given descriptor
 name already exists in the pool and was put there via a call to an add function.

 @param realVecValue The datum to associate with `name`.
 @param name The descriptor name of the datum to set.
 */
- (void)setRealVecValue:(nonnull OBJCRealVec)realVecValue forName:(nonnull OBJCString)name {
  _pool->set(name.cppString, realVecValue.realVecValue);
}

/**
 Sets the value of a descriptor name.

 This function is different than the add functions because set does not append data to the
 existing data under a given descriptor name, it sets it. Thus there can only be one datum
 associated with a descriptor name introduced to the pool via the set function. This function is
 useful when there is only one value associated with a given descriptor name.

 The set function cannot be used to override the data of a descriptor name that was introduced
 to the Pool via the add function. An EssentiaException will be thrown if the given descriptor
 name already exists in the pool and was put there via a call to an add function.

 @param stringValue The datum to associate with `name`.
 @param name The descriptor name of the datum to set.
 */
- (void)setStringValue:(nonnull OBJCString)stringValue forName:(nonnull OBJCString)name {
  _pool->set(name.cppString, stringValue.cppString);
}

/**
 Sets the value of a descriptor name.

 This function is different than the add functions because set does not append data to the
 existing data under a given descriptor name, it sets it. Thus there can only be one datum
 associated with a descriptor name introduced to the pool via the set function. This function is
 useful when there is only one value associated with a given descriptor name.

 The set function cannot be used to override the data of a descriptor name that was introduced
 to the Pool via the add function. An EssentiaException will be thrown if the given descriptor
 name already exists in the pool and was put there via a call to an add function.

 @param stringVecValue The datum to associate with `name`.
 @param name The descriptor name of the datum to set.
 */
- (void)setStringVecValue:(nonnull OBJCStringVec)stringVecValue
                     forName:(nonnull OBJCString)name
{
  _pool->set(name.cppString, stringVecValue.stringVecValue);
}

/**
 Merges the pool with the `pool`.

 If the pool contains a descriptor with name @e name, the current pool will keep its original
 descriptor values unless a type of merging is specified.

 Merge types can be:
 - "replace": if descriptor is not found it will be added to the pool otherwise it will remove the
 existing descriptor and subsitute it by the given one, regardless of type
 - "append": if descriptor is not found it will be added to the pool otherwise it will appended to
 the existing descriptor if and only if they share the same type.
 - "interleave": if descriptor is already in the pool, the new values will be interleaved with the
 existing ones if and only if they have the same type. If the descriptor is not
 found int the pool it will be added.

 @param pool The pool with which to merge.
 @param type A string indicating the type of merge to peform.
 */
- (void)mergeWithPool:(nonnull PoolWrapper *)pool type:(nonnull OBJCString)type
{
  _pool->merge(*(pool->_pool), type.cppString);
}

/**
 Merges the specified values into the pool for `name`.

 See documentation for `mergeWithPool:type:` for a discussion of the `type` parameter.

 @param realVecValue The values to marge into the pool.
 @param name The descriptor name underwhich to merge `realVecValue`.
 @param type A string indicating the type of merge to peform.
 */
- (void)mergeRealVecValue:(nonnull OBJCRealVec)realVecValue
                     forName:(nonnull OBJCString)name
                        type:(nonnull OBJCString)type
{
  _pool->merge(name.cppString, realVecValue.realVecValue, type.cppString);
}

/**
 Merges the specified values into the pool for `name`.

 See documentation for `mergeWithPool:type:` for a discussion of the `type` parameter.

 @param realVecVecValue The values to marge into the pool.
 @param name The descriptor name underwhich to merge `realVecVecValue`.
 @param type A string indicating the type of merge to peform.
 */
- (void)mergeRealVecVecValue:(nonnull OBJCRealVecVec)realVecVecValue
                           forName:(nonnull OBJCString)name
                              type:(nonnull OBJCString)type
{
  _pool->merge(name.cppString, realVecVecValue.realVecVecValue, type.cppString);
}

/**
 Merges the specified values into the pool for `name`.

 See documentation for `mergeWithPool:type:` for a discussion of the `type` parameter.

 @param stringVecValue The values to marge into the pool.
 @param name The descriptor name underwhich to merge `stringVecValue`.
 @param type A string indicating the type of merge to peform.
 */
- (void)mergeStringVecValue:(nonnull OBJCStringVec)stringVecValue
                       forName:(nonnull OBJCString)name
                          type:(nonnull OBJCString)type
{
  _pool->merge(name.cppString, stringVecValue.stringVecValue, type.cppString);
}

/**
 Merges the specified values into the pool for `name`.

 See documentation for `mergeWithPool:type:` for a discussion of the `type` parameter.

 @param stringVecVecValue The values to marge into the pool.
 @param name The descriptor name underwhich to merge `stringVecVecValue`.
 @param type A string indicating the type of merge to peform.
 */
- (void)mergeStringVecVecValue:(nonnull OBJCStringVecVec)stringVecVecValue
                             forName:(nonnull OBJCString)name
                                type:(nonnull OBJCString)type
{
  _pool->merge(name.cppString, stringVecVecValue.stringVecVecValue, type.cppString);
}

/**
 Merges the specified values into the pool for `name`.

 See documentation for `mergeWithPool:type:` for a discussion of the `type` parameter.

 @param realMatrixVecValue The values to marge into the pool.
 @param name The descriptor name underwhich to merge `realMatrixVecValue`.
 @param type A string indicating the type of merge to peform.
 */
- (void)mergeRealMatrixVecValue:(nonnull OBJCRealMatrixVec)realMatrixVecValue
                     forName:(nonnull OBJCString)name
                        type:(nonnull OBJCString)type
{
  _pool->merge(name.cppString, realMatrixVecValue.realMatrixVecValue, type.cppString);
}

/**
 Merges the specified values into the pool for `name`.

 See documentation for `mergeWithPool:type:` for a discussion of the `type` parameter.

 @param stereoSampleVecValue The values to marge into the pool.
 @param name The descriptor name underwhich to merge `stereoSampleVecValue`.
 @param type A string indicating the type of merge to peform.
 */
- (void)mergeStereoSampleVecValue:(nonnull OBJCStereoSampleVec)stereoSampleVecValue
                             forName:(nonnull OBJCString)name
                                type:(nonnull OBJCString)type
{
  _pool->merge(name.cppString, stereoSampleVecValue.stereoSampleVecValue, type.cppString);
}

/**
 Merges the specified value into the pool for `name`.

 See documentation for `mergeWithPool:type:` for a discussion of the `type` parameter.

 @param realValue The value to merge into the pool.
 @param name The descriptor name under which to merge `realValue`.
 @param type A string indicating the type of merge to peform.
 */
- (void)mergeSingleRealValue:(nonnull OBJCReal)realValue
                     forName:(nonnull OBJCString)name
                        type:(nonnull OBJCString)type
{
  _pool->mergeSingle(name.cppString, realValue.floatValue, type.cppString);
}

/**
 Merges the specified value into the pool for `name`.

 See documentation for `mergeWithPool:type:` for a discussion of the `type` parameter.

 @param realVecValue The value to merge into the pool.
 @param name The descriptor name under which to merge `realVecValue`.
 @param type A string indicating the type of merge to peform.
 */
- (void)mergeSingleRealVecValue:(nonnull OBJCRealVec)realVecValue
                           forName:(nonnull OBJCString)name
                              type:(nonnull OBJCString)type
{
  _pool->mergeSingle(name.cppString, realVecValue.realVecValue, type.cppString);
}

/**
 Merges the specified value into the pool for `name`.

 See documentation for `mergeWithPool:type:` for a discussion of the `type` parameter.

 @param stringValue The value to merge into the pool.
 @param name The descriptor name under which to merge `stringValue`.
 @param type A string indicating the type of merge to peform.
 */
- (void)mergeSingleStringValue:(nonnull OBJCString)stringValue
                       forName:(nonnull OBJCString)name
                          type:(nonnull OBJCString)type
{
  _pool->mergeSingle(name.cppString, stringValue.cppString, type.cppString);
}

/**
 Merges the specified value into the pool for `name`.

 See documentation for `mergeWithPool:type:` for a discussion of the `type` parameter.

 @param stringVecValue The value to merge into the pool.
 @param name The descriptor name under which to merge `stringVecValue`.
 @param type A string indicating the type of merge to peform.
 */
- (void)mergeSingleStringVecValue:(nonnull OBJCStringVec)stringVecValue
                             forName:(nonnull OBJCString)name
                                type:(nonnull OBJCString)type
{
  _pool->mergeSingle(name.cppString, stringVecValue.stringVecValue, type.cppString);
}

/**
 Removes the descriptor `name` from the pool along with the data it points to. This function
 does nothing if `name` does not exist in the pool.

 @param name The name of the descriptor to remove.
 */
- (void)removeName:(nonnull OBJCString)name {
  _pool->remove(name.cppString);
}

/**
 Removes the entire descriptor `nameSpace` from the pool along with the data it points to. This
 function does nothing if `nameSpace` does not exist in the pool.

 @param nameSpace The name of the descriptor to remove.
 */
- (void)removeNameSpace:(nonnull OBJCString)nameSpace {
  _pool->removeNamespace(nameSpace.cppString);
}

/**
 Accessor for the data associated with a descriptor. An exception is thrown if there is not any
 data associated with `name` of the appropriate return type.

 @param name The descriptor for which to retrieve associated data.
 @return The data associated with `name` or `nil` if there is no data for `name`.
 */
- (nonnull OBJCReal)realValueForName:(nonnull OBJCString)name {
  return [NSNumber numberWithFloat:_pool->value<Real>(name.cppString)];
}

/**
 Accessor for the data associated with a descriptor. An exception is thrown if there is not any
 data associated with `name` of the appropriate return type.

 @param name The descriptor for which to retrieve associated data.
 @return The data associated with `name` or `nil` if there is no data for `name`.
 */
- (nonnull OBJCString)stringValueForName:(nonnull OBJCString)name {
  return [NSString stringWithCPPString:_pool->value<String>(name.cppString)];
}

/**
 Accessor for the data associated with a descriptor. An exception is thrown if there is not any
 data associated with `name` of the appropriate return type.

 @param name The descriptor for which to retrieve associated data.
 @return The data associated with `name` or `nil` if there is no data for `name`.
 */
- (nonnull OBJCRealVecVec)realVecVecValueForName:(nonnull OBJCString)name {
  auto value = _pool->value<RealVecVec>(name.cppString);
  return [NSArray arrayWithRealVecVec: value];
}

/**
 Accessor for the data associated with a descriptor. An exception is thrown if there is not any
 data associated with `name` of the appropriate return type.

 @param name The descriptor for which to retrieve associated data.
 @return The data associated with `name` or `nil` if there is no data for `name`.
 */
- (nonnull OBJCStringVecVec)stringVecVecValueForName:(nonnull OBJCString)name {
  auto value = _pool->value<StringVecVec>(name.cppString);
  return [NSArray arrayWithStringVecVec:value];
}

/**
 Accessor for the data associated with a descriptor. An exception is thrown if there is not any
 data associated with `name` of the appropriate return type.

 @param name The descriptor for which to retrieve associated data.
 @return The data associated with `name` or `nil` if there is no data for `name`.
 */
- (nonnull OBJCRealMatrixVec)realMatrixVecValueForName:(nonnull OBJCString)name {
  auto value = _pool->value<RealMatrixVec>(name.cppString);
  return [NSArray arrayWithRealMatrixVec:value];
}

/**
 Accessor for the data associated with a descriptor. An exception is thrown if there is not any
 data associated with `name` of the appropriate return type.

 @param name The descriptor for which to retrieve associated data.
 @return The data associated with `name` or `nil` if there is no data for `name`.
 */
- (nonnull OBJCStereoSampleVec)stereoSampleVecValueForName:(nonnull OBJCString)name {
  auto value = _pool->value<StereoSampleVec>(name.cppString);
  return [NSArray arrayWithStereoSampleVec:value];
}

/**
 Accessor for the data associated with a descriptor. An exception is thrown if there is not any
 data associated with `name` of the appropriate return type.

 @param name The descriptor for which to retrieve associated data.
 @return The data associated with `name` or `nil` if there is no data for `name`.
 */
- (nonnull OBJCRealVec)realVecValueForName:(nonnull OBJCString)name {
  auto value = _pool->value<vector<Real>>(name.cppString);
  return [NSArray arrayWithRealVec:value];
}

/**
 Accessor for the data associated with a descriptor. An exception is thrown if there is not any
 data associated with `name` of the appropriate return type.

 @param name The descriptor for which to retrieve associated data.
 @return The data associated with `name` or `nil` if there is no data for `name`.
 */
- (nonnull OBJCStringVec)stringVecValueForName:(nonnull OBJCString)name {
  auto value = _pool->value<StringVec>(name.cppString);
  return [NSArray arrayWithStringVec:value];
}

/**
 Queries for the existence of the specified descriptor.

 @param name The descriptor name for which to query the pool.
 @return `YES` if the pool contains `name` and `NO` otherwise.
 */
- (BOOL)containsName:(nonnull OBJCString)name {
  return (   [self containsRealForName:name]
          || [self containsRealVecForName:name]
          || [self containsRealVecVecForName:name]
          || [self containsStringForName:name]
          || [self containsStringVecForName:name]
          || [self containsStringVecVecForName:name]
          || [self containsRealMatrixVecForName:name]
          || [self containsStereoSampleVecForName:name]
          );
}

/**
 Queries for the existence of the specified descriptor for a real value.

 @param name The descriptor for which to query the pool.
 @return `YES` if the pool contains `name` and the associated data is a real value and
         `NO` otherwise.
 */
- (BOOL)containsRealForName:(nonnull OBJCString)name {
  return (BOOL)_pool->contains<Real>(name.cppString);
}

/**
 Queries for the existence of the specified descriptor for a real vector value.

 @param name The descriptor for which to query the pool.
 @return `YES` if the pool contains `name` and the associated data is a real vector value and
 `NO` otherwise.
 */
- (BOOL)containsRealVecForName:(nonnull OBJCString)name {
  return (BOOL)_pool->contains<vector<Real>>(name.cppString);
}

/**
 Queries for the existence of the specified descriptor for a real vector vector value.

 @param name The descriptor for which to query the pool.
 @return `YES` if the pool contains `name` and the associated data is a real vector vector value
         and `NO` otherwise.
 */
- (BOOL)containsRealVecVecForName:(nonnull OBJCString)name {
  return (BOOL)_pool->contains<vector<vector<Real>>>(name.cppString);
}

/**
 Queries for the existence of the specified descriptor for a string value.

 @param name The descriptor for which to query the pool.
 @return `YES` if the pool contains `name` and the associated data is a string value and
 `NO` otherwise.
 */
- (BOOL)containsStringForName:(nonnull OBJCString)name {
  return (BOOL)_pool->contains<string>(name.cppString);
}

/**
 Queries for the existence of the specified descriptor for a string vector value.

 @param name The descriptor for which to query the pool.
 @return `YES` if the pool contains `name` and the associated data is a string vector value and
 `NO` otherwise.
 */
- (BOOL)containsStringVecForName:(nonnull OBJCString)name {
  return (BOOL)_pool->contains<vector<string>>(name.cppString);
}

/**
 Queries for the existence of the specified descriptor for a string vector vector value.

 @param name The descriptor for which to query the pool.
 @return `YES` if the pool contains `name` and the associated data is a string vector vector
         value and `NO` otherwise.
 */
- (BOOL)containsStringVecVecForName:(nonnull OBJCString)name {
  return (BOOL)_pool->contains<vector<vector<string>>>(name.cppString);
}

/**
 Queries for the existence of the specified descriptor for a real matrix vector value.

 @param name The descriptor for which to query the pool.
 @return `YES` if the pool contains `name` and the associated data is a real matrix vector
         value and `NO` otherwise.
 */
- (BOOL)containsRealMatrixVecForName:(nonnull OBJCString)name {
  return (BOOL)_pool->contains<vector<RealMatrix>>(name.cppString);
}

/**
 Queries for the existence of the specified descriptor for a stereo sample vector value.

 @param name The descriptor for which to query the pool.
 @return `YES` if the pool contains `name` and the associated data is a stereo sample
         vector value and `NO` otherwise.
 */
- (BOOL)containsStereoSampleVecForName:(nonnull OBJCString)name {
  return (BOOL)_pool->contains<vector<StereoSample>>(name.cppString);
}

/**
 The list of descriptor names in the pool.
 */
- (OBJCStringVec)descriptorNames {
  auto value = _pool->descriptorNames();
  return [NSArray arrayWithStringVec:value];
}

/**
 Queries for all descriptors in the pool under a specified namespace.

 @param ns The namespace for which to query.
 @return An array of all descriptors in the pool under `ns`.
 */
- (OBJCStringVec)descriptorNamesForNamespace:(NSString *)ns {
  auto value = _pool->descriptorNames(ns.cppString);
  return [NSArray arrayWithStringVec:value];
}

/**
 A map of real values inserted into the pool via `addRealValue:name:`.
 */
- (OBJCRealVecMap)realPool {
  return [NSDictionary dictionaryWithRealVecMap:_pool->getRealPool()];
}

/**
 A map of real vector values inserted into the pool via `addRealVecValue:name:`.
 */
- (OBJCRealVecVecMap)realVecPool {
  return [NSDictionary dictionaryWithRealVecVecMap:_pool->getVectorRealPool()];
}

/**
 A map of string values inserted into the pool via `addStringValue:name:`.
 */
- (OBJCStringVecMap)stringPool {
  return [NSDictionary dictionaryWithStringVecMap:_pool->getStringPool()];
}

/**
 A map of string vector values inserted into the pool via `addStringVecValue:name:`.
 */
- (OBJCStringVecVecMap)stringVecPool {
  return [NSDictionary dictionaryWithStringVecVecMap:_pool->getVectorStringPool()];
}

/**
 A map of real matrix values inserted into the pool via `addRealMatrixValue:name:`.
 */
- (OBJCRealMatrixVecMap)realMatrixPool {
  return [NSDictionary dictionaryWithRealMatrixVecMap:_pool->getArray2DRealPool()];
}

/**
 A map of stereo sample values inserted into the pool via `addStereoSampleValue:name:`.
 */
- (OBJCStereoSampleVecMap)stereoSamplePool {
  return [NSDictionary dictionaryWithStereoSampleVecMap:_pool->getStereoSamplePool()];
}

/**
 A map of real values inserted into the pool via `setRealValue:name:`.
 */
- (OBJCRealMap)realSinglePool {
  return [NSDictionary dictionaryWithRealMap:_pool->getSingleRealPool()];
}

/**
 A map of string values inserted into the pool via `setStringValue:name:`.
 */
- (OBJCStringMap)stringSinglePool {
  return [NSDictionary dictionaryWithStringMap:_pool->getSingleStringPool()];
}

/**
 A map of real vector values inserted into the pool via `setRealVecValue:name:`.
 */
- (OBJCRealVecMap)realVecSinglePool {
  return [NSDictionary dictionaryWithRealVecMap:_pool->getSingleVectorRealPool()];
}

/**
 A map of string vector values inserted into the pool via `setStringVecValue:name:`.
 */
- (OBJCStringVecMap)stringVecSinglePool {
  return [NSDictionary dictionaryWithStringVecMap:_pool->getSingleVectorStringPool()];
}

/**
 Checks that no descriptor name is in two different inner pool types at the same time; otherwise,
 an exception is thrown.
 */
- (void)checkIntegrity {  _pool->checkIntegrity();  }

/**
 Clears all the values contained in the pool.
 */
- (void)clear {  _pool->clear();  }

/**
 Queries whether the pool contains a given descriptor and that it appears in one of the single
 value pools.

 @param name The descriptor name for which to query the pool.
 @return `YES` if the pool contains `name` in a single value pool and `NO` otherwise.
 */
- (BOOL)isSingleValueDescriptorName:(OBJCString)name {
  return (BOOL)_pool->isSingleValue(name.cppString);
}


@end
