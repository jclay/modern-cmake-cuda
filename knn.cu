#include <thrust/sort.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>

using namespace std;

class Point {
public:
    Point() = default;
  __host__ __device__
    Point(double x, double y) : x(x), y(y) {};
  double x, y;
};

__device__ Point d_query_point;

 template<typename T>
 struct device_sort {
  typedef T first_argument_type;
  typedef T second_argument_type;
  typedef bool result_type;
 
   __host__ __device__ bool operator()(const T &a, const T &b) const {
  // Not concerned with actual distances, so skip the sqrt
    double norm_a = (a.x - d_query_point.x) * (a.x - d_query_point.x) + (a.y - d_query_point.y) * (a.y - d_query_point.y);
    double norm_b = (b.x - d_query_point.x) * (b.x - d_query_point.x) + (b.y - d_query_point.y) * (b.y - d_query_point.y);
    return norm_a < norm_b;
     //return true;
   }
 };

 // This simple "hello world" example implements the kNearestNeighbors example on a set of example 2D points.
int main(void) {
    thrust::device_vector<Point> d_points;
    thrust::host_vector<Point> h_points;

    Point query_point = Point(0,0);

    h_points.push_back(Point(2, 0));
    h_points.push_back(Point(1, 0));
    h_points.push_back(Point(0, 10));
    h_points.push_back(Point(5, 5));
    h_points.push_back(Point(2, 5));

    cudaMemcpyToSymbol(d_query_point, &query_point, sizeof(Point));
    // transfer to device
    d_points = h_points;

    thrust::sort(d_points.begin(), d_points.end(), device_sort<Point>());

    // transfer results to host
    h_points = d_points;

    for (const auto p : h_points) {
      cout << p.x << ", " << p.y << endl;  
    }

    return 0;
}