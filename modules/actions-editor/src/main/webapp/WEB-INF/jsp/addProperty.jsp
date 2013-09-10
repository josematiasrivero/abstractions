<jsp:include page="/WEB-INF/jsp/header.jsp">
  <jsp:param name="title" value="Add property"/>
</jsp:include>

<body>
  <nav class="navbar navbar-default navbar-static-top navbar-inverse" role="navigation">
    <div class="collapse navbar-collapse navbar-ex1-collapse">
      <ul class="nav navbar-nav">
        <li class="active"><a href="#">Home</a></li>
        <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Applications<b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="#">App 1</a></li>
          </ul></li>
      </ul>
    </div>
  </nav>

  <div class="container">
    <div class="row">
      <div class="col-lg-6">
        <ol class="breadcrumb">
          <li><a href="#">App 1</a></li>
          <li><a href="properties.htm">Properties</a></li>
          <li class="active">Add property</li>
        </ol>
      </div>

      <div class="row">
        <div class="col-lg-9">
          <form class="form-horizontal" role="form">

            <div class="form-group">
              <label for="inputName" class="col-lg-2 control-label">Property name</label>
              <div class="col-lg-10">
                <input type="text" class="form-control" id="inputName" name="propertyName" placeholder="Property name...">
              </div>
            </div>

            <div class="form-group">
              <label for="inputValue" class="col-lg-2 control-label">Property value</label>
              <div class="col-lg-10">
                <input type="text" class="form-control" id="inputValue" name="propertyValue" placeholder="Property value...">
              </div>
            </div>


            <div class="form-group">
              <div class="col-lg-offset-2 col-lg-10">
                <button type="submit" class="btn btn-primary">Save</button>
              </div>
            </div>
          </form>
        </div>
      </div>

    </div>
</body>
</html>