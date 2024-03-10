

import Foundation
import NeedleFoundation
import SwiftUI

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

private class MainScreenRouterComponentDependencyd1934decc02019116c04Provider: MainScreenRouterComponentDependency {
    var accountsManagementComponent: AccountsManagementComponent {
        return mainComponent.accountsManagementComponent
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->MainScreenRouterComponent
private func factory33430430ae8566dba0090ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return MainScreenRouterComponentDependencyd1934decc02019116c04Provider(mainComponent: parent1(component) as! MainComponent)
}
private class RegistrationComponentDependency45ce06ac0365c929bb6bProvider: RegistrationComponentDependency {


    init() {

    }
}
/// ^->MainComponent->RegistrationComponent
private func factorybf509de48c6e5261a880e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return RegistrationComponentDependency45ce06ac0365c929bb6bProvider()
}
private class AccountsManagementComponentDependency669d5ec8a455227cbbf2Provider: AccountsManagementComponentDependency {
    var transactionsManagementComponent: TransactionsManagementComponent {
        return mainComponent.transactionsManagementComponent
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->AccountsManagementComponent
private func factoryd2e351d5572dd753b3a30ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return AccountsManagementComponentDependency669d5ec8a455227cbbf2Provider(mainComponent: parent1(component) as! MainComponent)
}
private class AuthenticationComponentDependency1e61ff2125d745c6221dProvider: AuthenticationComponentDependency {


    init() {

    }
}
/// ^->MainComponent->AuthenticationComponent
private func factory78cd42ac479e5779494fe3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return AuthenticationComponentDependency1e61ff2125d745c6221dProvider()
}
private class TransactionsManagementComponentDependency928b87524ecf5e883c98Provider: TransactionsManagementComponentDependency {


    init() {

    }
}
/// ^->MainComponent->TransactionsManagementComponent
private func factorybcd967df3bbda91b70eae3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return TransactionsManagementComponentDependency928b87524ecf5e883c98Provider()
}

#else
extension MainComponent: Registration {
    public func registerItems() {


    }
}
extension MainScreenRouterComponent: Registration {
    public func registerItems() {
        keyPathToName[\MainScreenRouterComponentDependency.accountsManagementComponent] = "accountsManagementComponent-AccountsManagementComponent"
    }
}
extension RegistrationComponent: Registration {
    public func registerItems() {

    }
}
extension AccountsManagementComponent: Registration {
    public func registerItems() {
        keyPathToName[\AccountsManagementComponentDependency.transactionsManagementComponent] = "transactionsManagementComponent-TransactionsManagementComponent"
    }
}
extension AuthenticationComponent: Registration {
    public func registerItems() {

    }
}
extension TransactionsManagementComponent: Registration {
    public func registerItems() {

    }
}


#endif

private func factoryEmptyDependencyProvider(_ component: NeedleFoundation.Scope) -> AnyObject {
    return EmptyDependencyProvider(component: component)
}

// MARK: - Registration
private func registerProviderFactory(_ componentPath: String, _ factory: @escaping (NeedleFoundation.Scope) -> AnyObject) {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: componentPath, factory)
}

#if !NEEDLE_DYNAMIC

@inline(never) private func register1() {
    registerProviderFactory("^->MainComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->MainComponent->MainScreenRouterComponent", factory33430430ae8566dba0090ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->RegistrationComponent", factorybf509de48c6e5261a880e3b0c44298fc1c149afb)
    registerProviderFactory("^->MainComponent->AccountsManagementComponent", factoryd2e351d5572dd753b3a30ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->AuthenticationComponent", factory78cd42ac479e5779494fe3b0c44298fc1c149afb)
    registerProviderFactory("^->MainComponent->TransactionsManagementComponent", factorybcd967df3bbda91b70eae3b0c44298fc1c149afb)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
