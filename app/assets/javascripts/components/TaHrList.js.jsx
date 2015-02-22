var TaHrList = React.createClass({

  render: function() {
    var messageListItems = [];

    this.props.hrs.forEach(function(hr) {
      messageListItems.push(<li>{hr.description}</li>);
    });

    return (
      <ul>{messageListItems}</ul>
    );
  }
});




