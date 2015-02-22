var TaHrList = React.createClass({

  render: function() {
    var hrListItems = [];
    console.log(this.props.hrs)
    this.props.hrs.forEach(function(hr) {
      hrListItems.push(<li>{hr.description}</li>);
    });

    return (
      <ul>{hrListItems}</ul>
    );
  }
});
