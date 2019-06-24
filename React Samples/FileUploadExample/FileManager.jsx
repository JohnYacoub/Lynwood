import ContentWrapper from "../layout/ContentWrapper";
import FileUpload from "./FileUpload";
import FileCard from "./FileCard";
import swal from "sweetalert";
import React from "react";
import {
  Row,
  Col,
  Button,
  InputGroupAddon,
  InputGroup,
  Input
} from "reactstrap";
import {
  deleteFile,
  uploadFile,
  getAllPaginated,
  searchPaginated
} from "../../services/filesService";
// import logger from "../../logger";
// const _logger = logger.extend("FileManager");

class FileManager extends React.Component {
  state = {
    files: [],
    filesComp: [],
    currentFile: {},
    query: "",
    pageIndex: 0,
    pageSize: 12,
    hasNextPage: false,
    pageNumber: 0
  };

  componentDidMount = () => {
    getAllPaginated(this.state.pageIndex, this.state.pageSize)
      .then(this.onFilesSuccess)
      .catch(this.onError);
  };

  onFilesSuccess = r => {
    const files = r.item.pagedItems;
    const totalPages = r.item.totalPages;
    const hasNextPage = r.item.hasNextPage;
    const hasPrevPage = r.item.hasPreviousPage;
    const filesComp = r.item.pagedItems.map(this.mapList);
    this.setState(() => {
      return {
        files: files,
        filesComp: filesComp,
        totalPages: totalPages,
        hasNextPage: hasNextPage,
        hasPrevPage: hasPrevPage
      };
    });
  };

  onError = () => {
    swal({
      title: "Oops, Something went wrong.",
      text: "Please try again later",
      icon: "warning",
      timer: 2000,
      button: false
    });
  };

  onSearchError = () => {
    swal({
      title: "Oops, record not found",
      text: "Please search another.",
      icon: "warning",
      button: false
    });
  };

  loadFile = file => {
    this.setState({
      currentFile: file
    });
  };

  isEmpty = obj => {
    for (var key in obj) {
      if (obj.hasOwnProperty(key)) return false;
    }
    return true;
  };

  uploadFile = loaded => {
    if (!this.isEmpty(loaded)) {
      const fd = new FormData();
      for (let i = 0; i < loaded.length; i++) {
        fd.append("file", loaded[i], loaded[i].name);
      }
      uploadFile(fd)
        .then(this.onFileUploadSuccess)
        .then(
          getAllPaginated(this.state.pageIndex, this.state.pageSize).then(
            this.onFilesSuccess
          )
        )

        .catch(this.onError);
    } else {
      swal({
        title: "Please choose a file",
        icon: "error",
        button: "Okay"
      });
    }
  };

  onFileUploadSuccess = () => {
    swal({
      title: "Sweet!",
      icon: "success",
      timer: 1500,
      button: false
    });
    getAllPaginated(this.state.pageIndex, this.state.pageSize)
      .then(this.onFilesSuccess)
      .catch(this.onError);
  };

  deleteFile = id => {
    swal({
      title: "Are you sure?",
      text: "Once deleted, you will not be able to recover this file!",
      icon: "warning",
      buttons: true,
      dangerMode: true
    }).then(willDelete => {
      if (willDelete) {
        deleteFile(id)
          .then(() => {
            this.onDeleteSuccess(id);
          })
          .catch(this.onError);
        swal({
          title: "Poof! Your file has been deleted!",
          icon: "success"
        });
      } else {
        swal("Your file is safe!");
      }
    });
  };

  onDeleteSuccess = id => {
    const files = [...this.state.files];
    const index = files.findIndex(file => file.id === id);
    files.splice(index, 1);
    const filesComp = files.map(this.mapList);
    this.setState(() => {
      return {
        files: files,
        filesComp: filesComp
      };
    });
  };

  mapList = file => {
    return <FileCard file={file} key={file.id} deleteFile={this.deleteFile} />;
  };

  fileUpload = file => {
    return (
      <FileUpload file={file} key={file.id} deleteFile={this.deleteFile} />
    );
  };

  changeHandler = evt => {
    let key = evt.target.name;
    let val = evt.target.value;
    this.setState(() => {
      return {
        [key]: val
      };
    });
  };

  searchClickHandler = () => {
    let pageNumber = 0;
    searchPaginated(pageNumber, this.state.pageSize, this.state.query)
      .then(this.onFilesSuccess)
      .catch(this.onSearchError);
  };

  nextClickHandler = () => {
    if (this.state.hasNextPage) {
      this.setState(
        () => {
          return {
            pageIndex: this.state.pageIndex + 1
          };
        },
        () => {
          if (this.state.query) {
            this.setState(
              () => {
                return { pageNumber: this.state.pageNumber + 1 };
              },
              () => {
                if (this.state.totalPages > this.state.pageNumber) {
                  searchPaginated(
                    this.state.pageNumber,
                    this.state.pageSize,
                    this.state.query
                  )
                    .then(this.onFilesSuccess)
                    .catch(this.onError);
                }
              }
            );
          } else if (this.state.pageIndex < this.state.totalPages) {
            getAllPaginated(this.state.pageIndex, this.state.pageSize)
              .then(this.onFilesSuccess)
              .catch(this.onError);
          }
        }
      );
    }
  };

  prevClickHandler = () => {
    if (this.state.hasPrevPage && this.state.pageIndex >= 1) {
      this.setState(
        () => {
          return {
            pageIndex: this.state.pageIndex - 1
          };
        },
        () => {
          if (this.state.query) {
            this.setState(
              () => {
                return { pageNumber: this.state.pageNumber - 1 };
              },
              () => {
                if (this.state.pageNumber >= 0) {
                  searchPaginated(
                    this.state.pageNumber,
                    this.state.pageSize,
                    this.state.query
                  )
                    .then(this.onFilesSuccess)
                    .catch(this.onError);
                }
              }
            );
          } else {
            getAllPaginated(this.state.pageIndex, this.state.pageSize)
              .then(this.onFilesSuccess)
              .catch(this.onError);
          }
        }
      );
    }
  };

  keyPress = e => {
    let pageNumber = 0;
    if (e.keyCode === 13) {
      searchPaginated(pageNumber, this.state.pageSize, this.state.query)
        .then(this.onFilesSuccess)
        .catch(this.onSearchError);
    }
  };

  clearSearchHandler = () => {
    this.setState({ query: "", pageIndex: 0, pageNumber: 0 }, () => {
      getAllPaginated(this.state.pageIndex, this.state.pageSize)
        .then(this.onFilesSuccess)
        .catch(this.onError);
    });
  };

  render() {
    return (
      <ContentWrapper>
        <Row>
          <InputGroup>
            <Input
              bsSize="lg"
              placeholder="Search by Company Name, Description, Business Type, or Resource Type"
              onChange={this.changeHandler}
              name="query"
              onKeyDown={this.keyPress}
              value={this.state.query}
            />
            <InputGroupAddon addonType="append">
              <Button
                outline
                color="secondary"
                onClick={this.searchClickHandler}
              >
                <em className="fas fa-search" />
              </Button>
            </InputGroupAddon>
            <InputGroupAddon addonType="append">
              <Button
                outline
                color="secondary"
                onClick={this.clearSearchHandler}
              >
                <em className="fas fa-undo-alt" />
              </Button>
            </InputGroupAddon>
          </InputGroup>
        </Row>
        <h1 className="mt-3">File Manager</h1>
        <Row>
          <Col md={3}>
            <FileUpload
              currentFile={this.state.currentFile}
              uploadFile={this.uploadFile}
              loadFile={this.loadFile}
            />
          </Col>
          <Col md={9}>
            <Row>{this.state.filesComp}</Row>
            <Row>
              <Col xs="3">
                <Button
                  className="button4 list-card"
                  size="lg"
                  block
                  onClick={this.prevClickHandler}
                >
                  Previous
                </Button>
              </Col>
              <Col xs="6" />
              <Col xs="3">
                <Button
                  className="button4 list-card"
                  size="lg"
                  block
                  onClick={this.nextClickHandler}
                >
                  Next
                </Button>
              </Col>
            </Row>
          </Col>
        </Row>
      </ContentWrapper>
    );
  }
}

export default FileManager;
