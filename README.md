# Stella

Stella is a sample fashion application featuring the classic master detail pattern. It starts up by showing a list of departments. Once the user selects one of them a list of department's products is shown. This list displays basic information about products and allow user to go into a detail screen, by tapping on a product in the list.

This is the basic concept, the document will describe the application from an architecture standpoint. Specific implementation details can be found in code documentation.

## Architecture

Application's architecture stands upon two fundamental key concepts: *data providers* and *model view viewmodel*. The first concept is concerned with data retrieval, the latter is deals with data presentation.

### Data providers

Being application's content data driven, one of the first concerns is to provide an interface to define objects capable to provide this data. The interface is called *IDataProvider* and is declared inside *IDataProvider.swift* file.

Interface's definition is rather simple: it features a method to request data and a method to eventually cancel this request, should the need arise for application purposes (for instance if a screen is loading data but gets destroyed while doing it, implementation can interrupt the data request operation).

Based on application scope the following concrete data providers are implemented:

* *DepartmentDataProvider*: retrieves data about available departments. For application purposes this data is hardcoded within provider's implementation.
* *HTTPDataProvider*: is responsible to get data from http. Once data is available it gets passed throughout a decoder that transforms it in the required type.
* *ProductsDataProvider*: this is built as an extension of *HTTPDataProvider* and will get department's products list.
* *ProductImagesProvider*: used to get specific products image.

With those providers application can respond to its requirements.

### Model View ViewModel

When it comes to presentation layer many techniques are available. The aim of the current implementation is to avoid massive application's view controllers, because that could be a problem in many ways:

* *maintainability*: having control flow and data presentation logic all in one place really gets in the way. Often what is needed to do is to change the appearance of a controller and it can be quite difficult in this situation.
* *prototyping*: as a consequence of the previous point prototyping can become quite a hassle. Prototyping it's a vital part of application development and it should be simple to do it.
* *testability*: a monolithical piece of code isn't testable in any meaningful way. Testable systems emerges by separating concerns and responsibility among implementation's actors.

For this reason the pattern implemented here is the *Model View ViewModel*. There are many ways to implement this. Some implementations gives to view model many responsibility, like getting the data from data sources.  For this application the *mvvm* implementation takes a different path. Just as data is represented by a model, each of application's view are represented by a view model interface. For instance let's say we have this view:
```swift
class SomeTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel : UILabel!
}
```

It's view model interface would be something like:
```swift
protocol SomeCellViewModelInterface : ViewModel {
    var title : String { get }
}
```

With this in place and a simple bind function implemented into the view's definition we can bind data to the defined cell, as long as it conforms the view's view model interface.

This will set things up from view's perspective, but how about the data model? Model follows a similar path. Suppose a model is defined:

```swift
struct Department {
    var name : String
}
```

To let this model bindable to the previously defined *CategoryTableViewCell* a view model must be declared:

```swift
struct DepartmentSomeCellViewModel : SomeCellViewModelInterface {
    private department:Department
    init(department:Department) {
        self.department = department
    }
    
    var title : String { return department.name }
}
```

With this the cycle is complete allowing binding of a *Department* to *SomeTableViewCell*.
As stated before the view is in charge of binding, and it ends up like this:
```swift
class SomeTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel : UILabel!
    func bind(viewModel:SomeCellViewModelInterface) {
        titleLabel.text = viewModel.title
    }
}
```

For here on the code con bind any kind of data to the cell, as long as the viewModelInterface is provided.

## Putting it all together
With *data providers* and *mvvm* pattern put in place the application development becomes a matter of connecting dots.

### Detail screen
Detail screen is declared in file *ProductDetailViewController.swift*. The screen class inherits from *UIViewController* and defines a bindable view named detailView. Following the mvvm pattern described before, the controller expects a *ProductModel* instance that gets presented by the detail view during *viewDidLoad()* method.

### Department and Product list screens
Those screens show elements inside a *UITableView* so they inherit from *UITableViewController*. To avoid unnecessary code duplication some generalization have been put in place. Those generalizations are aimed to support data loaders and the *mvvm* pattern described before.

Data loading responsibility belongs to the generic table view controller declared inside *GenericTableViewController.swift* file. To do so the class declares a generic data provider (whose definition is founded in *IDataProvider.swift* file) whose in charge to load the data as soon as the controller did load its view.

The other generalization deals with table view's data source. The intent is to provide some kind of interface that makes it easy to select what cell needs to be shown into the table views and what binding strategy to apply on cell display. The implementation can be found inside *TableViewDataSource.swift* file, but the gist of it is that:

- it exposes a closure that returns the view model of the item that needs to be shown
- it exposes a closure that returns the item's cell reuse identifier.

Also it implements tableView's *cellForRowAtindexPath* method by leveraging those two closure and by finally bind the item data to the dequeued cell.

With this setup the department and product screens implementations becomes trivial as it can be seen into *DepartmentViewController.swift* and *ProductListViewController*

## In conclusion
There are many ways to put in place an architecture for this kind of application, the particular one implemented here has been chosed because it provides a good balance between code reuse techniques, scalability and scope.

The idea of *data providers* and the *mvvm* pattern decouples logics where it really belongs, thus allowing for effective collaboration during application developer (someone can be in charge of developing data providers and models, someone may want to implement views while someone else can implement application navigation logics and so on and so forth) which is always good.

*Data provider* proved themselves interesting because they can be tailored to specific needs. In the application those have been used to provide static data, data from a remote api and a remote image resource provider. The latter is quite interesting because being used as an application's service, it would be easy to provide a caching mechanism within its implementation.

Also by analyzing current application scope the technique of the generic tableview/data source has been used to reduce code size, thus reducing possible source of bugs. This particular idea could lead to other clever uses: one could be put this behind a layer of interfaces and make an abstraction so that it could be easy to choose between an *UITableViewController* and an *UICollectionViewController*. Therefore with clever planning view models may be completely reused for data binding.

