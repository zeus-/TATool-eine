var StudentHrList = React.createClass({
  
  getInitialState: function() {
    return {
      tas: this.props.tas,
      description: "",
      showInput: false
    }
  },

  componentDidMount: function() {
    var self = this;
  },
  
  deleteHr: function(studentHrs) {
    $.ajax({
      url: '/students/' + studentHrs.student_id + '/help_requests/' + studentHrs.id,
      type: 'DELETE',
      error: function() {
       alert('Could not delete!') 
      }
    })
  },

  openInput: function(i) {             
  /* var elem = (this.refs.x.getDOMNode())
    elem.outerHTML = "<input id='xx' refs='xxx'> </input>";
    var input = document.getElementById("xx")
    input.value = studentHrs.description;
    input.onSubmit */
    console.log(i)           
   this.setState({ showInput: true }); 
  },

  render: function() {
    var allItems = [];
    var self = this;
    var gravatarAddy = "http://www.gravatar.com/avatar/"  
    this.props.tas.forEach(function(taObject, i) {
      var taMD5Email = md5(taObject.email)
      var taGravatarLink = gravatarAddy + taMD5Email
      var helpRequests = [];
      
      // Add all help requests to array
      
      taObject.open_help_requests.forEach(function(studentHrs, number) {
        var studentMD5Email = md5(studentHrs.student_email)
        var studentGravatarLink = gravatarAddy + studentMD5Email
        self.state.description = studentHrs.description
        helpRequests.push(
          <div key={number} className="student-hr">
            <div className="student-hr-content">
              <img src={studentGravatarLink} />
              <p>  
              { self.state.showInput ? <EditInputField hrs= {studentHrs} /> : "I need help with " +  self.state.description  } 
              </p>
              <h5> -Asked by: {studentHrs.student_full_name} </h5>
              <button id="trash" onClick= {self.deleteHr.bind(self, studentHrs)} >
                <i className="fa fa-trash fa-lg"></i> 
              </button>
              <span className="edit" onClick= {self.openInput.bind(self, number)}>

               <i className="fa fa-pencil fa-lg"></i> 
              </span>

            </div>
          </div>
        )
      })
      
      allItems.push(
        <div key= { i } className="col-sm-6 top">
          <div className= "student-header"> 
            <img src= { taGravatarLink } > </img>
            <h2> Help Requests for  {taObject.first_name} </h2>
            <NewHrForm ta={taObject.id} onNewHr={self.props.forceUpdate} />
          </div>
          {helpRequests}
        </div>
      )
    });
  
    return (
      <div>
        {allItems}
      </div>
    );
  }
});
