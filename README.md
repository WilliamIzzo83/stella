# Stella

Stella is a sample fashion application featuring the classic master detail pattern. It starts up by showing a list of departments. Once the user can select one of them a list of department's products is shown. This list displays basic information about products and allow user to go into a detail scren, by tapping on a product in the list.

This is the basic concept, the document will describe the application from an architecture standpoint. Specific implementation details can be found in code documentation.

## Architecture

Application's architecture stands upon two fundamental key concepts: *data providers* and *model view viewmodel*. The first concept is concerned with data retrieval, the latter is concerned about data presentation.

### Data providers

Being application's content data driven one of the first concerns is to provide an interface to define objects capable to provide this data. The interface is called *IDataProvider* and is declared inside *IDataProvider.swift* file.

Interface's definition is rather simple: it features a method to request data and a method to eventually cancel this request, should the need arise for application purposes (for instance if a screen is loading data but gets destroyed while doing it, implementation canto interrupt the data request operation).

Based on application scope the following concrete data providers are implemented:

* *DepartmentDataProvider*: retrieves data about available departments. For application purposes this data is hardcoded in app.
* *HTTPDataProvider*: is responsible to get data from http. Once data is available it gets passed throughout a decoder that transforms it in the required type.
* *ProductsDataProvider*: this is built as an extension of *HTTPDataProvider* and will get department's products list.
* *ProductImagesProvider*: used to get specific products image.

With those providers application can respond to its requirements.

### Model View ViewModel

When it comes to presentation layer many techniques are available. The aim of the current implementation is to avoid massive application's view controllers, because that could be a problem in many ways:

* *maintainability*: having control flow and data presentation logic all in one place really gets in the way. Often what is needed to do is to change the appearance of a controller and it can be quite difficult in this situation.
* *prototyping*: as a consequence of the previous point prototyping can become quite a hassle. Prototyping it's a vital part of application development and it should be simple to do it.
* *testability*: one could simply not test a monolithical piece of code in any meaningful way. Testable systems emerges by separating concerns and responsibility among implementation's actors.

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

## Putting it all togheter



