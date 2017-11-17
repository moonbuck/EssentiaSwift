//
//  Network.swift
//  Essentia
//
//  Created by Jason Cardwell on 10/24/17.
//  Copyright © 2017 Moondeer Studios. All rights reserved.
//
import Foundation

/// The Swift-facing interface for `NetworkWrapper`.
public class Network {

  /// The bridge between the C++ `Network` and the Swift `Network`.
  internal let wrapper: NetworkWrapper

  /// Initializing the network wrapper with a root algorithm.
  ///
  /// - Parameter generator: The algorithm to serve as the root of the network.
  public init<Spec>(generator: StreamingAlgorithm<Spec>) {
    wrapper = NetworkWrapper(generator: generator.streamingWrapper)
  }

  /// Executes all the algorithms in the network until all the tokens given by the source generator are
  /// processed by all the algorithms. Internally it just calls runPrepare and then runStep repeatedly.
  public func run() { wrapper.run() }

  /// Does the preparation needed to process the tokens of the network.
  public func runPrepare() { wrapper.runPrepare() }

  /// Processes all tokens generated with one call of `process` on the generator.
  ///
  /// - Returns: `false` if there are no more tokens to process and `true` otherwise.
  public func runStep() -> Bool { return wrapper.runStep() }

  /// Rebuilds the visible and execution network.
  public func update() { wrapper.update() }

  /// Invokes `reset` for each algorithm contained in the network.
  public func reset() { wrapper.reset() }

  /// Clear the network to an empty state (ie: no algorithms contained in it). Deletes previous
  /// algorithms if the network had ownership of them.
  public func clear() { wrapper.clear() }

  /// Queries the network for an algorithm with the specified name. An exception is thrown if the
  /// network does not contain an algorithm with the specified name.
  ///
  /// - Parameter name: The name of the algorithm to find.
  /// - Returns: A proxy for the algorithm matching `name`.
  public func findAlgorithm<Spec:StreamingSpecification>(name: String) -> StreamingAlgorithm<Spec> {

    let algorithmWrapper = wrapper.findAlgorithm(withName: name)

    guard let algorithmID = Streaming.AlgorithmID(rawValue: algorithmWrapper.name) else {
      fatalError("Failed to retrieve algorithm ID using same '\(algorithmWrapper.name)'.")
    }

    let streamingSpec: Spec.Type = algorithmID.spec()

    let algorithm = streamingSpec.downCast(wrapper: algorithmWrapper)

    return algorithm
  }

  /// Return a list of algorithms which have been topologically sorted.
  public var linearExecutionOrder: [AnyStreamingAlgorithm] {
    return wrapper.linearExecutionOrder.map(AnyStreamingAlgorithm.init(wrapper:))
  }

  /// The network node at the root of the visible algorithm network.
  public var visibleNetworkRoot: Node? {
    guard let nodeWrapper = wrapper.visibleNetworkRoot else { return nil }
    return Node(wrapper: nodeWrapper)
  }

}

extension Network: CustomStringConvertible {

  public var description: String {
    return """
      Network {
        execution order: \(linearExecutionOrder.map(\.name).joined(separator: " ➤ "))
        visible root: \(visibleNetworkRoot?.description ?? "none")
      }
      """
  }

}

extension Network {

  /// The Swift-facing interface for `NetworkNodeWrapper`.
  public class Node: CustomStringConvertible {

    /// The node wrapper.
    internal let wrapper: NetworkNodeWrapper

    /// Initializing with a node wrapper.
    ///
    /// - Parameter wrapper: The node wrapper.
    internal init(wrapper: NetworkNodeWrapper) { self.wrapper = wrapper }

    /// The array of child nodes.
    public var children: [Node] {
      get { return wrapper.children.map(Node.init(wrapper:)) }
      set { wrapper.children = newValue.map({$0.wrapper}) }
    }

    /// The algorithm with which the node is associated.
    public var algorithm: AnyStreamingAlgorithm {
      return AnyStreamingAlgorithm(wrapper: wrapper.algorithm)
    }

    /// A description of the node's children and associated algorithm.
    public var description: String {
      return """
        Node { algorithm: \(algorithm.name); \
        children: [\(children.map(\.algorithm.name).joined(separator: ", "))] }
        """
    }

  }

}
