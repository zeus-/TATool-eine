var StudentHrList = React.createClass({

  render: function() {
    var messageListItems = [];

    this.props.hrs.forEach(function(message) {
      messageListItems.push(<li>{message.description}</li>);
    });

    return (
      <ul>{messageListItems}</ul>
    );
  }
});
