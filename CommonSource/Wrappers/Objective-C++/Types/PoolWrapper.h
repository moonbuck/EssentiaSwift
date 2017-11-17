//
//  PoolWrapper.h
//  Essentia
//
//  Created by Jason Cardwell on 10/11/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "WrappedTypes.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Wrapper class that serves to bridge the C++ class `Pool`.
 */
@interface PoolWrapper: NSObject

/**
 Initializing by creating a new instance of `Pool`.

 @return The newly intialized wrapper for a newly created pool.
 */
- (instancetype)init;

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
- (void)addRealValue:(OBJCReal)realValue forName:(OBJCString)name;

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
- (void)addRealVecValue:(OBJCRealVec)realVecValue
                  forName:(OBJCString)name;

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
- (void)addStringValue:(OBJCString)stringValue forName:(OBJCString)name;

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
- (void)addStringVecValue:(OBJCStringVec)stringVecValue
                    forName:(OBJCString)name;

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
- (void)addRealMatrixValue:(OBJCRealMatrix)realMatrixValue
                  forName:(OBJCString)name;

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
- (void)addStereoSampleValue:(OBJCStereoSample)stereoSampleValue
                    forName:(OBJCString)name;

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
- (void)setRealValue:(OBJCReal)realValue forName:(OBJCString)name;

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
- (void)setRealVecValue:(OBJCRealVec)realVecValue forName:(OBJCString)name;

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
- (void)setStringValue:(OBJCString)stringValue forName:(OBJCString)name;

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
- (void)setStringVecValue:(OBJCStringVec)stringVecValue
                     forName:(OBJCString)name;

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
- (void)mergeWithPool:(PoolWrapper *)pool type:(OBJCString)type;

/**
 Merges the specified values into the pool for `name`.

 See documentation for `mergeWithPool:type:` for a discussion of the `type` parameter.

 @param realVecValue The values to marge into the pool.
 @param name The descriptor name underwhich to merge `realVecValue`.
 @param type A string indicating the type of merge to peform.
 */
- (void)mergeRealVecValue:(OBJCRealVec)realVecValue
                     forName:(OBJCString)name
                        type:(OBJCString)type;

/**
 Merges the specified values into the pool for `name`.

 See documentation for `mergeWithPool:type:` for a discussion of the `type` parameter.

 @param realVecVecValue The values to marge into the pool.
 @param name The descriptor name underwhich to merge `realVecVecValue`.
 @param type A string indicating the type of merge to peform.
 */
- (void)mergeRealVecVecValue:(OBJCRealVecVec)realVecVecValue
                     forName:(OBJCString)name
                        type:(OBJCString)type;

/**
 Merges the specified values into the pool for `name`.

 See documentation for `mergeWithPool:type:` for a discussion of the `type` parameter.

 @param stringVecValue The values to marge into the pool.
 @param name The descriptor name underwhich to merge `stringVecValue`.
 @param type A string indicating the type of merge to peform.
 */
- (void)mergeStringVecValue:(OBJCStringVec)stringVecValue
                     forName:(OBJCString)name
                        type:(OBJCString)type;

/**
 Merges the specified values into the pool for `name`.

 See documentation for `mergeWithPool:type:` for a discussion of the `type` parameter.

 @param stringVecVecValue The values to marge into the pool.
 @param name The descriptor name underwhich to merge `stringVecVecValue`.
 @param type A string indicating the type of merge to peform.
 */
- (void)mergeStringVecVecValue:(OBJCStringVecVec)stringVecVecValue
                     forName:(OBJCString)name
                        type:(OBJCString)type;

/**
 Merges the specified values into the pool for `name`.

 See documentation for `mergeWithPool:type:` for a discussion of the `type` parameter.

 @param realMatrixVecValue The values to marge into the pool.
 @param name The descriptor name underwhich to merge `realMatrixVecValue`.
 @param type A string indicating the type of merge to peform.
 */
- (void)mergeRealMatrixVecValue:(OBJCRealMatrixVec)realMatrixVecValue
                     forName:(OBJCString)name
                        type:(OBJCString)type;

/**
 Merges the specified values into the pool for `name`.

 See documentation for `mergeWithPool:type:` for a discussion of the `type` parameter.

 @param stereoSampleVecValue The values to marge into the pool.
 @param name The descriptor name underwhich to merge `stereoSampleVecValue`.
 @param type A string indicating the type of merge to peform.
 */
- (void)mergeStereoSampleVecValue:(OBJCStereoSampleVec)stereoSampleVecValue
                     forName:(OBJCString)name
                        type:(OBJCString)type;

/**
 Merges the specified value into the pool for `name`.

 See documentation for `mergeWithPool:type:` for a discussion of the `type` parameter.

 @param realValue The value to merge into the pool.
 @param name The descriptor name under which to merge `realValue`.
 @param type A string indicating the type of merge to peform.
 */
- (void)mergeSingleRealValue:(OBJCReal)realValue
                     forName:(OBJCString)name
                        type:(OBJCString)type;

/**
 Merges the specified value into the pool for `name`.

 See documentation for `mergeWithPool:type:` for a discussion of the `type` parameter.

 @param realVecValue The value to merge into the pool.
 @param name The descriptor name under which to merge `realVecValue`.
 @param type A string indicating the type of merge to peform.
 */
- (void)mergeSingleRealVecValue:(OBJCRealVec)realVecValue
                           forName:(OBJCString)name
                              type:(OBJCString)type;

/**
 Merges the specified value into the pool for `name`.

 See documentation for `mergeWithPool:type:` for a discussion of the `type` parameter.

 @param stringValue The value to merge into the pool.
 @param name The descriptor name under which to merge `stringValue`.
 @param type A string indicating the type of merge to peform.
 */
- (void)mergeSingleStringValue:(OBJCString)stringValue
                       forName:(OBJCString)name
                          type:(OBJCString)type;

/**
 Merges the specified value into the pool for `name`.

 See documentation for `mergeWithPool:type:` for a discussion of the `type` parameter.

 @param stringVecValue The value to merge into the pool.
 @param name The descriptor name under which to merge `stringVecValue`.
 @param type A string indicating the type of merge to peform.
 */
- (void)mergeSingleStringVecValue:(OBJCStringVec)stringVecValue
                             forName:(OBJCString)name
                                type:(OBJCString)type;

/**
 Removes the descriptor `name` from the pool along with the data it points to. This function
 does nothing if `name` does not exist in the pool.

 @param name The name of the descriptor to remove.
 */
- (void)removeName:(OBJCString)name;

/**
 Removes the entire descriptor `nameSpace` from the pool along with the data it points to. This
 function does nothing if `nameSpace` does not exist in the pool.

 @param nameSpace The name of the descriptor to remove.
 */
- (void)removeNameSpace:(OBJCString)nameSpace;

/**
 Accessor for the data associated with a descriptor. An exception is thrown if there is not any
 data associated with `name` of the appropriate return type.

 @param name The descriptor for which to retrieve associated data.
 @return The data associated with `name` or `nil` if there is no data for `name`.
 */
- (OBJCReal)realValueForName:(OBJCString)name;

/**
 Accessor for the data associated with a descriptor. An exception is thrown if there is not any
 data associated with `name` of the appropriate return type.

 @param name The descriptor for which to retrieve associated data.
 @return The data associated with `name` or `nil` if there is no data for `name`.
 */
- (OBJCString)stringValueForName:(OBJCString)name;

/**
 Accessor for the data associated with a descriptor. An exception is thrown if there is not any
 data associated with `name` of the appropriate return type.

 @param name The descriptor for which to retrieve associated data.
 @return The data associated with `name` or `nil` if there is no data for `name`.
 */
- (OBJCRealVecVec)realVecVecValueForName:(OBJCString)name;

/**
 Accessor for the data associated with a descriptor. An exception is thrown if there is not any
 data associated with `name` of the appropriate return type.

 @param name The descriptor for which to retrieve associated data.
 @return The data associated with `name` or `nil` if there is no data for `name`.
 */
- (OBJCStringVecVec)stringVecVecValueForName:(OBJCString)name;

/**
 Accessor for the data associated with a descriptor. An exception is thrown if there is not any
 data associated with `name` of the appropriate return type.

 @param name The descriptor for which to retrieve associated data.
 @return The data associated with `name` or `nil` if there is no data for `name`.
 */
- (OBJCRealMatrixVec)realMatrixVecValueForName:(OBJCString)name;

/**
 Accessor for the data associated with a descriptor. An exception is thrown if there is not any
 data associated with `name` of the appropriate return type.

 @param name The descriptor for which to retrieve associated data.
 @return The data associated with `name` or `nil` if there is no data for `name`.
 */
- (OBJCStereoSampleVec)stereoSampleVecValueForName:(OBJCString)name;

/**
 Accessor for the data associated with a descriptor. An exception is thrown if there is not any
 data associated with `name` of the appropriate return type.

 @param name The descriptor for which to retrieve associated data.
 @return The data associated with `name` or `nil` if there is no data for `name`.
 */
- (OBJCRealVec)realVecValueForName:(OBJCString)name;

/**
 Accessor for the data associated with a descriptor. An exception is thrown if there is not any
 data associated with `name` of the appropriate return type.

 @param name The descriptor for which to retrieve associated data.
 @return The data associated with `name` or `nil` if there is no data for `name`.
 */
- (OBJCStringVec)stringVecValueForName:(OBJCString)name;

/**
 Queries for the existence of the specified descriptor.

 @param name The descriptor name for which to query the pool.
 @return `YES` if the pool contains `name` and `NO` otherwise.
 */
- (BOOL)containsName:(OBJCString)name;

/**
 Queries for the existence of the specified descriptor for a real value.

 @param name The descriptor for which to query the pool.
 @return `YES` if the pool contains `name` and the associated data is a real value and
 `NO` otherwise.
 */
- (BOOL)containsRealForName:(nonnull OBJCString)name;

/**
 Queries for the existence of the specified descriptor for a real vector value.

 @param name The descriptor for which to query the pool.
 @return `YES` if the pool contains `name` and the associated data is a real vector value and
 `NO` otherwise.
 */
- (BOOL)containsRealVecForName:(nonnull OBJCString)name;

/**
 Queries for the existence of the specified descriptor for a real vector vector value.

 @param name The descriptor for which to query the pool.
 @return `YES` if the pool contains `name` and the associated data is a real vector vector value
 and `NO` otherwise.
 */
- (BOOL)containsRealVecVecForName:(nonnull OBJCString)name;

/**
 Queries for the existence of the specified descriptor for a string value.

 @param name The descriptor for which to query the pool.
 @return `YES` if the pool contains `name` and the associated data is a string value and
 `NO` otherwise.
 */
- (BOOL)containsStringForName:(nonnull OBJCString)name;

/**
 Queries for the existence of the specified descriptor for a string vector value.

 @param name The descriptor for which to query the pool.
 @return `YES` if the pool contains `name` and the associated data is a string vector value and
 `NO` otherwise.
 */
- (BOOL)containsStringVecForName:(nonnull OBJCString)name;

/**
 Queries for the existence of the specified descriptor for a string vector vector value.

 @param name The descriptor for which to query the pool.
 @return `YES` if the pool contains `name` and the associated data is a string vector vector
 value and `NO` otherwise.
 */
- (BOOL)containsStringVecVecForName:(nonnull OBJCString)name;

/**
 Queries for the existence of the specified descriptor for a real matrix vector value.

 @param name The descriptor for which to query the pool.
 @return `YES` if the pool contains `name` and the associated data is a real matrix vector
 value and `NO` otherwise.
 */
- (BOOL)containsRealMatrixVecForName:(nonnull OBJCString)name;

/**
 Queries for the existence of the specified descriptor for a stereo sample vector value.

 @param name The descriptor for which to query the pool.
 @return `YES` if the pool contains `name` and the associated data is a stereo sample
 vector value and `NO` otherwise.
 */
- (BOOL)containsStereoSampleVecForName:(nonnull OBJCString)name;

/**
 The list of descriptor names in the pool.
 */
@property (nonatomic, readonly) OBJCStringVec descriptorNames;

/**
 Queries for all descriptors in the pool under a specified namespace.

 @param ns The namespace for which to query.
 @return An array of all descriptors in the pool under `ns`.
 */
- (OBJCStringVec)descriptorNamesForNamespace:(NSString *)ns;

/**
 A map of real values inserted into the pool via `addRealValue:name:`.
 */
@property (nonatomic, readonly) OBJCRealVecMap realPool;

/**
 A map of real vector values inserted into the pool via `addRealVecValue:name:`.
 */
@property (nonatomic, readonly) OBJCRealVecVecMap realVecPool;

/**
 A map of string values inserted into the pool via `addStringValue:name:`.
 */
@property (nonatomic, readonly) OBJCStringVecMap stringPool;

/**
 A map of string vector values inserted into the pool via `addStringVecValue:name:`.
 */
@property (nonatomic, readonly) OBJCStringVecVecMap stringVecPool;

/**
 A map of real matrix values inserted into the pool via `addRealMatrixValue:name:`.
 */
@property (nonatomic, readonly) OBJCRealMatrixVecMap realMatrixPool;

/**
 A map of stereo sample values inserted into the pool via `addStereoSampleValue:name:`.
 */
@property (nonatomic, readonly) OBJCStereoSampleVecMap stereoSamplePool;

/**
 A map of real values inserted into the pool via `setRealValue:name:`.
 */
@property (nonatomic, readonly) OBJCRealMap realSinglePool;

/**
 A map of string values inserted into the pool via `setStringValue:name:`.
 */
@property (nonatomic, readonly) OBJCStringMap stringSinglePool;

/**
 A map of real vector values inserted into the pool via `setRealVecValue:name:`.
 */
@property (nonatomic, readonly) OBJCRealVecMap realVecSinglePool;

/**
 A map of string vector values inserted into the pool via `setStringVecValue:name:`.
 */
@property (nonatomic, readonly) OBJCStringVecMap stringVecSinglePool;

/**
 Checks that no descriptor name is in two different inner pool types at the same time; otherwise,
 an exception is thrown.
 */
- (void)checkIntegrity;

/**
 Clears all the values contained in the pool.
 */
- (void)clear;

/**
 Queries whether the pool contains a given descriptor and that it appears in one of the single
 value pools.

 @param name The descriptor name for which to query the pool.
 @return `YES` if the pool contains `name` and as part of a single value pool and `NO` otherwise.
 */
- (BOOL)isSingleValueDescriptorName:(OBJCString)name;

@end

NS_ASSUME_NONNULL_END

