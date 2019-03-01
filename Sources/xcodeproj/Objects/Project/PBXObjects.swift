import Foundation

extension NSRecursiveLock {
    func sync<T>(closure: () -> (T)) -> T {
        lock()
        let value = closure()
        unlock()
        return value
    }
}

class PBXObjects: Equatable {
    // MARK: - Properties
    
    private let lock = NSRecursiveLock()

    private var unsyncProjects: [PBXObjectReference: PBXProject] = [:]
    var projects: [PBXObjectReference: PBXProject] {
        return lock.sync { unsyncProjects }
    }
    
    private var unsyncReferenceProxies: [PBXObjectReference: PBXReferenceProxy] = [:]
    var referenceProxies: [PBXObjectReference: PBXReferenceProxy] {
        return lock.sync { unsyncReferenceProxies }
    }

    // File elements
    private var unsyncFileReferences: [PBXObjectReference: PBXFileReference] = [:]
    var fileReferences: [PBXObjectReference: PBXFileReference] {
        return lock.sync { unsyncFileReferences }
    }
    private var unsyncVersionGroups: [PBXObjectReference: XCVersionGroup] = [:]
    var versionGroups: [PBXObjectReference: XCVersionGroup] {
        return lock.sync { unsyncVersionGroups }
    }
    private var unsyncVariantGroups: [PBXObjectReference: PBXVariantGroup] = [:]
    var variantGroups: [PBXObjectReference: PBXVariantGroup] {
        return lock.sync { unsyncVariantGroups }
    }
    private var unsyncGroups: [PBXObjectReference: PBXGroup] = [:]
    var groups: [PBXObjectReference: PBXGroup] {
        return lock.sync { unsyncGroups }
    }

    // Configuration
    private var unsyncBuildConfigurations: [PBXObjectReference: XCBuildConfiguration] = [:]
    var buildConfigurations: [PBXObjectReference: XCBuildConfiguration] {
        return lock.sync { unsyncBuildConfigurations }
    }
    private var unsyncConfigurationLists: [PBXObjectReference: XCConfigurationList] = [:]
    var configurationLists: [PBXObjectReference: XCConfigurationList] {
        return lock.sync { unsyncConfigurationLists }
    }

    // Targets
    private var unsyncLegacyTargets: [PBXObjectReference: PBXLegacyTarget] = [:]
    var legacyTargets: [PBXObjectReference: PBXLegacyTarget] {
        return lock.sync { unsyncLegacyTargets }
    }
    private var unsyncAggregateTargets: [PBXObjectReference: PBXAggregateTarget] = [:]
    var aggregateTargets: [PBXObjectReference: PBXAggregateTarget] {
        return lock.sync { unsyncAggregateTargets }
    }
    private var unsyncNativeTargets: [PBXObjectReference: PBXNativeTarget] = [:]
    var nativeTargets: [PBXObjectReference: PBXNativeTarget] {
        return lock.sync { unsyncNativeTargets }
    }
    private var unsyncTargetDependencies: [PBXObjectReference: PBXTargetDependency] = [:]
    var targetDependencies: [PBXObjectReference: PBXTargetDependency] {
        return lock.sync { unsyncTargetDependencies }
    }
    private var unsyncContainerItemProxies: [PBXObjectReference: PBXContainerItemProxy] = [:]
    var containerItemProxies: [PBXObjectReference: PBXContainerItemProxy] {
        return lock.sync { unsyncContainerItemProxies }
    }
    private var unsyncBuildRules: [PBXObjectReference: PBXBuildRule] = [:]
    var buildRules: [PBXObjectReference: PBXBuildRule] {
        return lock.sync { unsyncBuildRules }
    }

    // Build Phases
    private var unsyncBuildFiles: [PBXObjectReference: PBXBuildFile] = [:]
    var buildFiles: [PBXObjectReference: PBXBuildFile] {
        return lock.sync { unsyncBuildFiles }
    }
    private var unsyncCopyFilesBuildPhases: [PBXObjectReference: PBXCopyFilesBuildPhase] = [:]
    var copyFilesBuildPhases: [PBXObjectReference: PBXCopyFilesBuildPhase] {
        return lock.sync { unsyncCopyFilesBuildPhases }
    }
    private var unsyncShellScriptBuildPhases: [PBXObjectReference: PBXShellScriptBuildPhase] = [:]
    var shellScriptBuildPhases: [PBXObjectReference: PBXShellScriptBuildPhase] {
        return lock.sync { unsyncShellScriptBuildPhases }
    }
    private var unsyncResourcesBuildPhases: [PBXObjectReference: PBXResourcesBuildPhase] = [:]
    var resourcesBuildPhases: [PBXObjectReference: PBXResourcesBuildPhase] {
        return lock.sync { unsyncResourcesBuildPhases }
    }
    private var unsyncFrameworksBuildPhases: [PBXObjectReference: PBXFrameworksBuildPhase] = [:]
    var frameworksBuildPhases: [PBXObjectReference: PBXFrameworksBuildPhase] {
        return lock.sync { unsyncFrameworksBuildPhases }
    }
    private var unsyncHeadersBuildPhases: [PBXObjectReference: PBXHeadersBuildPhase] = [:]
    var headersBuildPhases: [PBXObjectReference: PBXHeadersBuildPhase] {
        return lock.sync { unsyncHeadersBuildPhases }
    }
    private var unsyncSourcesBuildPhases: [PBXObjectReference: PBXSourcesBuildPhase] = [:]
    var sourcesBuildPhases: [PBXObjectReference: PBXSourcesBuildPhase] {
        return lock.sync { unsyncSourcesBuildPhases }
    }
    private var unsyncCarbonResourcesBuildPhases: [PBXObjectReference: PBXRezBuildPhase] = [:]
    var carbonResourcesBuildPhases: [PBXObjectReference: PBXRezBuildPhase] {
        return lock.sync { unsyncCarbonResourcesBuildPhases }
    }

    /// Initializes the project objects container
    ///
    /// - Parameters:
    ///   - objects: project objects
    init(objects: [PBXObject] = []) {
        objects.forEach {
            _ = self.add(object: $0)
        }
    }

    // MARK: - Equatable

    public static func == (lhs: PBXObjects, rhs: PBXObjects) -> Bool {
        return lhs.buildFiles == rhs.buildFiles &&
            lhs.legacyTargets == rhs.legacyTargets &&
            lhs.aggregateTargets == rhs.aggregateTargets &&
            lhs.containerItemProxies == rhs.containerItemProxies &&
            lhs.copyFilesBuildPhases == rhs.copyFilesBuildPhases &&
            lhs.groups == rhs.groups &&
            lhs.configurationLists == rhs.configurationLists &&
            lhs.buildConfigurations == rhs.buildConfigurations &&
            lhs.variantGroups == rhs.variantGroups &&
            lhs.targetDependencies == rhs.targetDependencies &&
            lhs.sourcesBuildPhases == rhs.sourcesBuildPhases &&
            lhs.shellScriptBuildPhases == rhs.shellScriptBuildPhases &&
            lhs.resourcesBuildPhases == rhs.resourcesBuildPhases &&
            lhs.frameworksBuildPhases == rhs.frameworksBuildPhases &&
            lhs.headersBuildPhases == rhs.headersBuildPhases &&
            lhs.nativeTargets == rhs.nativeTargets &&
            lhs.fileReferences == rhs.fileReferences &&
            lhs.projects == rhs.projects &&
            lhs.versionGroups == rhs.versionGroups &&
            lhs.referenceProxies == rhs.referenceProxies &&
            lhs.carbonResourcesBuildPhases == rhs.carbonResourcesBuildPhases &&
            lhs.buildRules == rhs.buildRules
    }

    // MARK: - Helpers

    /// Add a new object.
    ///
    /// - Parameters:
    ///   - object: object.
    func add(object: PBXObject) {
        lock.lock()
        let objectReference: PBXObjectReference = object.reference
        objectReference.objects = self

        switch object {
        // subclasses of PBXGroup; must be tested before PBXGroup
        case let object as PBXVariantGroup: unsyncVariantGroups[objectReference] = object
        case let object as XCVersionGroup: unsyncVersionGroups[objectReference] = object

        // everything else
        case let object as PBXBuildFile: unsyncBuildFiles[objectReference] = object
        case let object as PBXAggregateTarget: unsyncAggregateTargets[objectReference] = object
        case let object as PBXLegacyTarget: unsyncLegacyTargets[objectReference] = object
        case let object as PBXContainerItemProxy: unsyncContainerItemProxies[objectReference] = object
        case let object as PBXCopyFilesBuildPhase: unsyncCopyFilesBuildPhases[objectReference] = object
        case let object as PBXGroup: unsyncGroups[objectReference] = object
        case let object as XCConfigurationList: unsyncConfigurationLists[objectReference] = object
        case let object as XCBuildConfiguration: unsyncBuildConfigurations[objectReference] = object
        case let object as PBXTargetDependency: unsyncTargetDependencies[objectReference] = object
        case let object as PBXSourcesBuildPhase: unsyncSourcesBuildPhases[objectReference] = object
        case let object as PBXShellScriptBuildPhase: unsyncShellScriptBuildPhases[objectReference] = object
        case let object as PBXResourcesBuildPhase: unsyncResourcesBuildPhases[objectReference] = object
        case let object as PBXFrameworksBuildPhase: unsyncFrameworksBuildPhases[objectReference] = object
        case let object as PBXHeadersBuildPhase: unsyncHeadersBuildPhases[objectReference] = object
        case let object as PBXNativeTarget: unsyncNativeTargets[objectReference] = object
        case let object as PBXFileReference: unsyncFileReferences[objectReference] = object
        case let object as PBXProject: unsyncProjects[objectReference] = object
        case let object as PBXReferenceProxy: unsyncReferenceProxies[objectReference] = object
        case let object as PBXRezBuildPhase: unsyncCarbonResourcesBuildPhases[objectReference] = object
        case let object as PBXBuildRule: unsyncBuildRules[objectReference] = object
        default: fatalError("Unhandled PBXObject type for \(object), this is likely a bug / todo")
        }
        lock.unlock()
    }

    /// Deletes the object with the given reference.
    ///
    /// - Parameter reference: referenc of the object to be deleted.
    /// - Returns: the deleted object.
    // swiftlint:disable:next function_body_length Note: SwiftLint doesn't disable if @discardable and the function are on different lines.
    @discardableResult func delete(reference: PBXObjectReference) -> PBXObject? {
        lock.lock()
        if let index = buildFiles.index(forKey: reference) {
            return unsyncBuildFiles.remove(at: index).value
        } else if let index = aggregateTargets.index(forKey: reference) {
            return unsyncAggregateTargets.remove(at: index).value
        } else if let index = legacyTargets.index(forKey: reference) {
            return unsyncLegacyTargets.remove(at: index).value
        } else if let index = containerItemProxies.index(forKey: reference) {
            return unsyncContainerItemProxies.remove(at: index).value
        } else if let index = groups.index(forKey: reference) {
            return unsyncGroups.remove(at: index).value
        } else if let index = configurationLists.index(forKey: reference) {
            return unsyncConfigurationLists.remove(at: index).value
        } else if let index = buildConfigurations.index(forKey: reference) {
            return unsyncBuildConfigurations.remove(at: index).value
        } else if let index = variantGroups.index(forKey: reference) {
            return unsyncVariantGroups.remove(at: index).value
        } else if let index = targetDependencies.index(forKey: reference) {
            return unsyncTargetDependencies.remove(at: index).value
        } else if let index = nativeTargets.index(forKey: reference) {
            return unsyncNativeTargets.remove(at: index).value
        } else if let index = fileReferences.index(forKey: reference) {
            return unsyncFileReferences.remove(at: index).value
        } else if let index = projects.index(forKey: reference) {
            return unsyncProjects.remove(at: index).value
        } else if let index = versionGroups.index(forKey: reference) {
            return unsyncVersionGroups.remove(at: index).value
        } else if let index = referenceProxies.index(forKey: reference) {
            return unsyncReferenceProxies.remove(at: index).value
        } else if let index = copyFilesBuildPhases.index(forKey: reference) {
            return unsyncCopyFilesBuildPhases.remove(at: index).value
        } else if let index = shellScriptBuildPhases.index(forKey: reference) {
            return unsyncShellScriptBuildPhases.remove(at: index).value
        } else if let index = resourcesBuildPhases.index(forKey: reference) {
            return unsyncResourcesBuildPhases.remove(at: index).value
        } else if let index = frameworksBuildPhases.index(forKey: reference) {
            return unsyncFrameworksBuildPhases.remove(at: index).value
        } else if let index = headersBuildPhases.index(forKey: reference) {
            return unsyncHeadersBuildPhases.remove(at: index).value
        } else if let index = sourcesBuildPhases.index(forKey: reference) {
            return unsyncSourcesBuildPhases.remove(at: index).value
        } else if let index = carbonResourcesBuildPhases.index(forKey: reference) {
            return unsyncCarbonResourcesBuildPhases.remove(at: index).value
        } else if let index = buildRules.index(forKey: reference) {
            return unsyncBuildRules.remove(at: index).value
        }
        lock.unlock()
        return nil
    }

    /// It returns the object with the given reference.
    ///
    /// - Parameter reference: Xcode reference.
    /// - Returns: object.
    // swiftlint:disable:next function_body_length
    func get(reference: PBXObjectReference) -> PBXObject? {
        // This if-let expression is used because the equivalent chain of `??` separated lookups causes,
        // with Swift 4, this compiler error:
        //     Expression was too complex to be solved in reasonable time;
        //     consider breaking up the expression into distinct sub-expressions
        if let object = buildFiles[reference] {
            return object
        } else if let object = aggregateTargets[reference] {
            return object
        } else if let object = legacyTargets[reference] {
            return object
        } else if let object = containerItemProxies[reference] {
            return object
        } else if let object = groups[reference] {
            return object
        } else if let object = configurationLists[reference] {
            return object
        } else if let object = buildConfigurations[reference] {
            return object
        } else if let object = variantGroups[reference] {
            return object
        } else if let object = targetDependencies[reference] {
            return object
        } else if let object = nativeTargets[reference] {
            return object
        } else if let object = fileReferences[reference] {
            return object
        } else if let object = projects[reference] {
            return object
        } else if let object = versionGroups[reference] {
            return object
        } else if let object = referenceProxies[reference] {
            return object
        } else if let object = copyFilesBuildPhases[reference] {
            return object
        } else if let object = shellScriptBuildPhases[reference] {
            return object
        } else if let object = resourcesBuildPhases[reference] {
            return object
        } else if let object = frameworksBuildPhases[reference] {
            return object
        } else if let object = headersBuildPhases[reference] {
            return object
        } else if let object = sourcesBuildPhases[reference] {
            return object
        } else if let object = carbonResourcesBuildPhases[reference] {
            return object
        } else if let object = buildRules[reference] {
            return object
        } else {
            return nil
        }
    }
}

// MARK: - Public

extension PBXObjects {
    /// Returns all the targets with the given name.
    ///
    /// - Parameters:
    ///   - name: target name.
    /// - Returns: targets with the given name.
    func targets(named name: String) -> [PBXTarget] {
        var targets: [PBXTarget] = []
        targets.append(contentsOf: nativeTargets.values.map({ $0 as PBXTarget }))
        targets.append(contentsOf: legacyTargets.values.map({ $0 as PBXTarget }))
        targets.append(contentsOf: aggregateTargets.values.map({ $0 as PBXTarget }))
        return targets.filter { $0.name == name }
    }

    /// Invalidates all the objects references.
    func invalidateReferences() {
        forEach {
            $0.reference.invalidate()
        }
    }

    // MARK: - Computed Properties

    var buildPhases: [PBXObjectReference: PBXBuildPhase] {
        var phases: [PBXObjectReference: PBXBuildPhase] = [:]
        phases.merge(copyFilesBuildPhases as [PBXObjectReference: PBXBuildPhase], uniquingKeysWith: { first, _ in return first })
        phases.merge(sourcesBuildPhases as [PBXObjectReference: PBXBuildPhase], uniquingKeysWith: { first, _ in return first })
        phases.merge(shellScriptBuildPhases as [PBXObjectReference: PBXBuildPhase], uniquingKeysWith: { first, _ in return first })
        phases.merge(resourcesBuildPhases as [PBXObjectReference: PBXBuildPhase], uniquingKeysWith: { first, _ in return first })
        phases.merge(headersBuildPhases as [PBXObjectReference: PBXBuildPhase], uniquingKeysWith: { first, _ in return first })
        phases.merge(carbonResourcesBuildPhases as [PBXObjectReference: PBXBuildPhase], uniquingKeysWith: { first, _ in return first })
        phases.merge(frameworksBuildPhases as [PBXObjectReference: PBXBuildPhase], uniquingKeysWith: { first, _ in return first })
        return phases
    }

    /// Runs the given closure for each of the objects that are part of the project.
    ///
    /// - Parameter closure: closure to be run.
    func forEach(_ closure: (PBXObject) -> Void) {
        buildFiles.values.forEach(closure)
        legacyTargets.values.forEach(closure)
        aggregateTargets.values.forEach(closure)
        containerItemProxies.values.forEach(closure)
        groups.values.forEach(closure)
        configurationLists.values.forEach(closure)
        versionGroups.values.forEach(closure)
        buildConfigurations.values.forEach(closure)
        variantGroups.values.forEach(closure)
        targetDependencies.values.forEach(closure)
        nativeTargets.values.forEach(closure)
        fileReferences.values.forEach(closure)
        projects.values.forEach(closure)
        referenceProxies.values.forEach(closure)
        buildRules.values.forEach(closure)
        copyFilesBuildPhases.values.forEach(closure)
        shellScriptBuildPhases.values.forEach(closure)
        resourcesBuildPhases.values.forEach(closure)
        frameworksBuildPhases.values.forEach(closure)
        headersBuildPhases.values.forEach(closure)
        sourcesBuildPhases.values.forEach(closure)
        carbonResourcesBuildPhases.values.forEach(closure)
    }
}
